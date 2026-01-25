//
//  FetchServiceProtocol.swift
//  Accounts
//
//  Created by Martin Hrbáček on 25.01.2026.
//

import Foundation

protocol FetchServiceProtocol: Sendable {
    func fetchAccounts() async throws -> [Account]
}
