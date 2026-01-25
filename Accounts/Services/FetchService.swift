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
    case httpError(Int)
    case decodingFail
}

struct FetchService {
    
    func fetchAccounts() async throws -> [Account] {
        
        guard let url = URL(string: APIConstants.baseURL+APIConstants.endpoints) else {
            print("Invalid URL")
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.addValue(Secrets.accountsAPIKey, forHTTPHeaderField: "web-api-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("HTTP Response Error")
            throw NetworkError.badResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Status Code Error: \(httpResponse.statusCode)")
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(AccountWrapper.self, from: data)
            return decoded.accounts
        } catch {
            print("Decoding Error")
            throw NetworkError.decodingFail
        }
    }
}
