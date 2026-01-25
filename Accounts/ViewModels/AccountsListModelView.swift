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
            errorMessage = StringConstants.errorMessage
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
        account.accountNumber ?? StringConstants.notAvailable
    }
    
    var bankCode: String {
        account.bankCode ?? StringConstants.notAvailable
    }
    
    var transparencyFrom: String {
        account.transparencyFrom ?? StringConstants.notAvailable
    }
    
    var transparencyTo: String {
        account.transparencyTo ?? StringConstants.notAvailable
    }
    
    var publicationTo: String {
        account.publicationTo ?? StringConstants.notAvailable
    }
    
    var actualizationDate: String {
        account.actualizationDate ?? StringConstants.notAvailable
    }
    
    var formattedBalance: String {
        let code = account.currency ?? StringConstants.unknownCurrency
        return "\(account.balance?.formatted(.number) ?? StringConstants.notAvailable) \(code)"
    }
    
    var currency: String {
        account.currency ?? StringConstants.notAvailable
    }
    
    var name: String {
        (account.name ?? StringConstants.notAvailable).trimmingCharacters(in: .whitespaces)
    }
    
    var description: String {
        account.description ?? StringConstants.notAvailable
    }
    
    var iban: String {
        account.iban ?? StringConstants.notAvailable
    }
}
