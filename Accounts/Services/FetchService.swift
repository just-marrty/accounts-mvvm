//
//  FetchService.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
}

@MainActor
struct FetchService {
    
    private let baseURL = "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3/transparentAccounts"
    
    // Fetching the nested Account array from TransparencyAccount
    func fetchAccounts() async throws -> [Account] {
        
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        // Create URLRequest demaned by header "web-api-key" based on Erste API documentation for Public Transparent Accounts API
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(Secrets.accountsAPIKey, forHTTPHeaderField: "web-api-key")
        
        // Use "data(for:)" instead of "data(from:)" because we must send the request with custom header (in this case "web-api-key)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        // Decode the wrapper (root) TransparencyAcount itself and then return decoded accounts which is nested Account array
        let decoded = try JSONDecoder().decode(TransparencyAccount.self, from: data)
        return decoded.accounts
    }
}
