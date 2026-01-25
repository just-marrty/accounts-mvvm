//
//  AccountViewModel+Extensions.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import Foundation

extension AccountViewModel {
    static let sampleAccountsDetailView = AccountViewModel(account: Account(
        accountNumber: "000182-0388063349",
        bankCode: "0800",
        transparencyFrom: "2013-12-18T00:00:00",
        transparencyTo: "3000-01-01T00:00:00",
        publicationTo: "3000-01-01T00:00:00",
        actualizationDate: "2018-01-17T13:01:34",
        balance: 0,
        currency: "CZK",
        name: "Město Černošice",
        description: "Veřejná sbírka - sportovní hala",
        iban: "CZ07 0800 0001 8203 8806 3349"
    ))
}
