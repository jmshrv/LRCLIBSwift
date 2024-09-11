//
//  Models.swift
//  LRCLIBSwift
//
//  Created by James on 11/09/2024.
//

public struct LyricRecord: Codable, Equatable, Identifiable {
    public let id: Int64
    public let name: String?
    public let trackName: String?
    public let artistName: String?
    public let albumName: String?
    public let duration: Double?
    public let instrumental: Bool
    public let plainLyrics: String?
    public let syncedLyrics: String?
}
