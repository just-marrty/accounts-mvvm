//
//  NetworkError.swift
//  Accounts
//
//  Created by Martin Hrbáček on 27.01.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case httpError(Int)
    case decodingFail
}
