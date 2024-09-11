//
//  LRCLIBSwift.swift
//  LRCLIBSwift
//
//  Created by James on 11/09/2024.
//

import Foundation

/// A LRCLIB client. All methods are accessed statically - LRCLIB doesn't need any state to be kept.
struct LrcLib {
    private static let baseUrl = URL(string: "https://lrclib.net/api")!
    
    private static let userAgent = "LRCLIBSwift v1.0.0 (https://github.com/jmshrv/LRCLIBSwift)"
    
    public static func get(
        trackName: String,
        artistName: String,
        albumName: String,
        duration: UInt
    ) async throws -> LyricRecord {
        return try await request(
            "/get",
            queryItems: [
                .init(name: "track_name", value: trackName),
                .init(name: "artist_name", value: artistName),
                .init(name: "album_name", value: albumName),
                .init(name: "duration", value: String(duration))
            ])
    }
    
    private static func request<T: Decodable>(_ endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        let route = baseUrl
            .appending(path: endpoint)
            .appending(queryItems: queryItems)
        
        var request = URLRequest(url: route)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
