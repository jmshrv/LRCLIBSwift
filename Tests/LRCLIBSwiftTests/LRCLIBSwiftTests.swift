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
