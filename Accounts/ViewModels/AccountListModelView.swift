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
    
    let fetchService: FetchService
    
    init(fetchService: FetchService) {
        self.fetchService = fetchService
    }
    
    func loadAccounts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let accounts = try await fetchService.fetchAccounts()
            self.accounts = accounts.map(AccountViewModel.init)
        } catch {
            errorMessage = "Cannot load data: \(error.localizedDescription)"
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
    
    // Thanks to the "typealias Account = TransparencyAccount.Account", we can simply write "Account" instead of the longer "TransparencyAccount.Account" type (everywhere in the app)
    private var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var id: UUID {
        account.id
    }
    
    var accountNumber: String {
        account.accountNumber ?? "N/A"
    }
    
    var bankCode: String {
        account.bankCode ?? "N/A"
    }
    
    var transparencyFrom: String {
        account.transparencyFrom ?? "N/A"
    }
    
    var transparencyTo: String {
        account.transparencyTo ?? "N/A"
    }
    
    var publicationTo: String {
        account.publicationTo ?? "N/A"
    }
    
    var actualizationDate: String {
        account.actualizationDate ?? "N/A"
    }
    
    var balance: Double {
        account.balance ?? 0.0
    }
    
    var currency: String {
        account.currency ?? "N/A"
    }
    
    var name: String {
        (account.name ?? "N/A").trimmingCharacters(in: .whitespaces) // Removes leading and trailing whitespace characters to prevent unwanted spacing in the UI. Especially when values come from a JSON API
    }
    
    var description: String {
        account.description ?? "N/A"
    }
    
    var iban: String {
        account.iban ?? "N/A"
    }
}
