//
//  AccountWrapper.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import Foundation

struct AccountWrapper: Decodable {
    let accounts: [Account]
    
    struct Account: Decodable, Hashable {
        var id = UUID()
        
        let accountNumber: String?
        let bankCode: String?
        let transparencyFrom: String?
        let transparencyTo: String?
        let publicationTo: String?
        let actualizationDate: String?
        let balance: Decimal?
        let currency: String?
        let name: String?
        let description: String?
        let iban: String?
        
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

typealias Account = AccountWrapper.Account

