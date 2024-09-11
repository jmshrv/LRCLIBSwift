//
//  LRCLIBSwift.swift
//  LRCLIBSwift
//
//  Created by James on 11/09/2024.
//

import Foundation

/// A LRCLIB client. All methods are accessed statically - LRCLIB doesn't need any state to be kept. Documentation for
/// each function is largely copied from https://lrclib.net/docs and adapted for this package.
public struct LrcLib {
    private static let baseUrl = URL(string: "https://lrclib.net/api")!
    
    private static let userAgent = "LRCLIBSwift v1.0.0 (https://github.com/jmshrv/LRCLIBSwift)"
    
    /// Attempt to find the best match of lyrics for the track. You must provide the exact signature of the track,
    /// including the track title, artist name, album name, and the track's duration in seconds.
    ///
    /// Each time you request a new track's signature, this API will attempt to access external sources in case the
    /// lyrics are not found in the internal database. Therefore, the response time will vary significantly. If you prefer to avoid this behavior, please set `cached` to `true`.
    ///
    /// **Note**: The provided `duration` is crucial. LRCLIB will attempt to provide the lyrics only when the duration
    /// matches the record in LRCLIB's database, or at least with a difference of ±2 seconds in duration.
    public static func get(
        trackName: String,
        artistName: String,
        albumName: String,
        duration: UInt,
        cached: Bool = false
    ) async throws -> LyricRecord {
        let endpoint = cached ? "/get-cached" : "/get"
        
        return try await request(
            endpoint,
            queryItems: [
                .init(name: "track_name", value: trackName),
                .init(name: "artist_name", value: artistName),
                .init(name: "album_name", value: albumName),
                .init(name: "duration", value: String(duration))
            ])
    }
    
    /// Get a lyrics record by an absolute ID. ID of a lyrics record can be retrieved from other APIs, such as
    /// `search()` API.
    public static func get(id: Int) async throws -> LyricRecord {
//        Making URLs with string interpolation is bad but it's just an Int so we'll live
        let endpoint = "/get/\(id)"
        
        return try await request(endpoint)
    }
    
    /// Search for lyrics records using keywords. This API returns an array of lyrics records that match the specified
    /// search condition(s).
    ///
    /// At least ONE of the two parameters, `query` OR `trackName`, must be present.
    ///
    /// **Note**: This API currently returns a maximum of 20 results and does not support pagination. These limitations
    /// are subject to change in the future. 
    public static func search(
        query: String? = nil,
        trackName: String? = nil,
        artistName: String? = nil,
        albumName: String? = nil
    ) async throws -> [LyricRecord] {
        guard query != nil || trackName != nil else {
            throw LrcLibError.searchBothNil
        }
        
        var queryItems: [URLQueryItem] = []
        
        if let query {
            queryItems.append(.init(name: "q", value: query))
        }
        
        if let trackName {
            queryItems.append(.init(name: "track_name", value: trackName))
        }
        
        if let artistName {
            queryItems.append(.init(name: "artist_name", value: artistName))
        }
        
        if let albumName {
            queryItems.append(.init(name: "album_name", value: albumName))
        }
        
        return try await request("/search", queryItems: queryItems)
    }
    
    private static func request<T: Decodable>(_ endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        let route = baseUrl
            .appending(path: endpoint)
            .appending(queryItems: queryItems)
        
        var request = URLRequest(url: route)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode >= 400 {
                throw LrcLibError.httpErrorCode(httpResponse.statusCode)
            }
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
