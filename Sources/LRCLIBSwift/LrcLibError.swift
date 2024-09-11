//
//  LrcLibError.swift
//  LRCLIBSwift
//
//  Created by James on 11/09/2024.
//

enum LrcLibError: Error, Equatable {
    /// A HTTP request had a 4xx or 5xx response code.
    ///
    /// - Parameter responseCode: The returned response code.
    case httpErrorCode(_ responseCode: Int)
}
