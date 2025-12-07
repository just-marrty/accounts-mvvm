//
//  Secrets.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import Foundation

struct Secrets {
    static var accountsAPIKey: String {
        guard let key = Bundle.main.infoDictionary?["ACCOUNTS_API_KEY"] as? String else {
            fatalError("Accounts API Key not found. Check Secrets.xcconfig")
        }
        return key
    }
}
