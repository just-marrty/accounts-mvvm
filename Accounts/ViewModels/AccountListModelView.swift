//
//  AccountListModelView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import Foundation
import Observation

@Observable
@MainActor
class AccountListModelView {
    var accounts: [AccountViewModel] = []
    var isLoading = false
    var errorMessage: String?
    
    private let fetchService: FetchService
    
    init(fetchService: FetchService) {
        self.fetchService = fetchService
    }
    
    func loadAccounts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let accounts = try await fetchService.fetchAccounts()
            self.accounts = accounts.map(AccountViewModel.init).sorted { $0.name < $1.name }
        } catch {
            errorMessage = StringConstants.errorMessage
        }
        
        isLoading = false
    }
    
    func search(for searchTherm: String) -> [AccountViewModel] {
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

struct AccountViewModel: Identifiable, Hashable {
    
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
    
    var balance: Decimal {
        account.balance ?? 0.0
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
