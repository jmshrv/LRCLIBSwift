//
//  Models.swift
//  LRCLIBSwift
//
//  Created by James on 11/09/2024.
//

struct LyricRecord: Codable, Equatable, Identifiable {
    let id: Int64
    let name: String?
    let trackName: String?
    let artistName: String?
    let albumName: String?
    let duration: Double?
    let instrumental: Bool
    let plainLyrics: String?
    let syncedLyrics: String?
}
