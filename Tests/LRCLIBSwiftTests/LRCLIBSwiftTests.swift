//
//  LRCLIBSwiftTests.swift
//  LRCLIBSwift
//
//  Created by James on 11/09/2024.
//

import Foundation
import Testing
@testable import LRCLIBSwift

@Test func get() async throws {
    let actual = try await LrcLib.get(
        trackName: "Welcome to the Black Parade",
        artistName: "My Chemical Romance",
        albumName: "Welcome to the Black Parade",
        duration: 311
    )
    
    #expect(actual.id == 571883)
    #expect(actual.trackName == "Welcome to the Black Parade")
    #expect(actual.artistName == "My Chemical Romance")
    #expect(actual.albumName == "Welcome to the Black Parade")
    #expect(actual.duration == 311)
}

@Test func getNotFound() async throws {
    await #expect(throws: LrcLibError.httpErrorCode(404)) {
        try await LrcLib.get(
            trackName: "invalid",
            artistName: "invalid",
            albumName: "invalid",
            duration: 1
        )
    }
}

@Test func getById() async throws {
    let actual = try await LrcLib.get(id: 571883)
    
    #expect(actual.id == 571883)
    #expect(actual.trackName == "Welcome to the Black Parade")
    #expect(actual.artistName == "My Chemical Romance")
    #expect(actual.albumName == "Welcome to the Black Parade")
    #expect(actual.duration == 311)
}

@Test func searchQuery() async throws {
    let actual = try await LrcLib.search(query: "still alive portal")
    
    #expect(!actual.isEmpty)
}

@Test func searchMultipleFields() async throws {
    let actual = try await LrcLib.search(
        trackName: "22",
        artistName: "taylor swift"
    )
    
    #expect(!actual.isEmpty)
}

@Test func searchInvalidParams() async throws {
    await #expect(throws: LrcLibError.searchBothNil) {
        try await LrcLib.search()
    }
}
