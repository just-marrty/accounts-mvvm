//
//  AccountsListModelView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import Foundation
import Observation

@Observable
@MainActor
class AccountsListModelView {
    var accounts: [AccountsViewModel] = []
    var isLoading = false
    var errorMessage: String?
    
    private let fetchService: FetchServiceProtocol
    
    init(fetchService: FetchServiceProtocol) {
        self.fetchService = fetchService
    }
    
    func loadAccounts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let accounts = try await fetchService.fetchAccounts()
            self.accounts = accounts.map(AccountsViewModel.init).sorted { $0.name < $1.name }
        } catch {
            errorMessage = Strings.errorMessage
        }
        
        isLoading = false
    }
    
    func search(for searchTherm: String) -> [AccountsViewModel] {
        if searchTherm.isEmpty {
            return accounts
        } else {
            return accounts.filter { account in
                account.name.localizedCaseInsensitiveContains(searchTherm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        if alphabetical {
            accounts.sort { $0.name < $1.name }
        } else {
            accounts.sort { $0.name > $1.name }
        }
    }
}

struct AccountsViewModel: Identifiable, Hashable {
    
    private var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var id: UUID {
        account.id
    }
    
    var accountNumber: String {
        account.accountNumber ?? Strings.notAvailable
    }
    
    var bankCode: String {
        account.bankCode ?? Strings.notAvailable
    }
    
    var transparencyFrom: String {
        account.transparencyFrom ?? Strings.notAvailable
    }
    
    var transparencyTo: String {
        account.transparencyTo ?? Strings.notAvailable
    }
    
    var publicationTo: String {
        account.publicationTo ?? Strings.notAvailable
    }
    
    var actualizationDate: String {
        account.actualizationDate ?? Strings.notAvailable
    }
    
    var formattedBalance: String {
        let code = account.currency ?? Strings.unknownCurrency
        return "\(account.balance?.formatted(.number) ?? Strings.notAvailable) \(code)"
    }
    
    var currency: String {
        account.currency ?? Strings.notAvailable
    }
    
    var name: String {
        (account.name ?? Strings.notAvailable).trimmingCharacters(in: .whitespaces)
    }
    
    var description: String {
        account.description ?? Strings.notAvailable
    }
    
    var iban: String {
        account.iban ?? Strings.notAvailable
    }
}
