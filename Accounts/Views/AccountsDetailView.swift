//
//  AccountsDetailView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import SwiftUI

struct AccountsDetailView: View {
    
    let account: AccountsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    infoRow(title: Strings.accountName, value: account.name)
                    infoRow(title: Strings.accountNumber, value: account.accountNumber)
                    infoRow(title: Strings.iban, value: account.iban)
                    infoRow(title: Strings.accountCurrency, value: account.currency)
                    infoRow(title: Strings.accountBalance, value: account.formattedBalance)
                    infoRow(title: Strings.transparencyFrom, value: account.transparencyFrom.formattedDateTime())
                    infoRow(title: Strings.transparencyTo, value: account.transparencyTo.formattedDateTime())
                    infoRow(title: Strings.actualizationDate, value: account.actualizationDate.formattedDateTime())
                    infoRow(title: Strings.accountDescription, value: account.description)
                }
            }
            .padding()
        }
        .navigationTitle(account.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    }
    
    private func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 18))
                .bold()
            Text(value)
                .font(.system(size: 18))
            Divider()
                .padding(5)
        }
    }
}

#Preview {
    NavigationStack {
        AccountsDetailView(account: .sampleAccountsDetailView)
    }
}
