//
//  TransparencyAccount.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import Foundation

// JSON wrapper - the root of JSON object returned by the API
// The API response contains metadata (pageNumber, pageSize, etc.), but for this app we only care about the "accounts" array
struct TransparencyAccount: Decodable {
    let accounts: [Account]
    
    // Model representing a single account inside the "accounts" array
    // This struct maps only the keys we actually need from the JSON
    struct Account: Decodable, Hashable {
        var id = UUID()
        
        let accountNumber: String?
        let bankCode: String?
        let transparencyFrom: String?
        let transparencyTo: String?
        let publicationTo: String?
        let actualizationDate: String?
        let balance: Double?
        let currency: String?
        let name: String?
        let description: String?
        let iban: String?
        
        // CodingKeys explicitly declare which JSON keys should be decoded
        // By defining this enum inside the `Account` struct, we ensure that only these fields are mapped from the JSON response
        // Properties not listed here, such as `id`, will be ignored during decoding — preventing keyNotFound errors
        enum CodingKeys: CodingKey {
            case accountNumber
            case bankCode
            case transparencyFrom
            case transparencyTo
            case publicationTo
            case actualizationDate
            case balance
            case currency
            case name
            case description
            case iban
        }
    }
}
// Aliasing the nested type so we can simply refer to it as "Account" throughout the app, instead of writing "TransparencyAccount.Account"
typealias Account = TransparencyAccount.Account

