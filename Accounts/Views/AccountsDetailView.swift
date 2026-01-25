//
//  AccountsDetailView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import SwiftUI

struct AccountsDetailView: View {
    
    let account: AccountViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    infoRow(title: StringConstants.accountName, value: account.name)
                    infoRow(title: StringConstants.accountNumber, value: account.accountNumber)
                    infoRow(title: StringConstants.iban, value: account.iban)
                    infoRow(title: StringConstants.accountCurrency, value: account.currency)
                    infoRow(title: StringConstants.accountBalance, value: account.balance.formatted(.currency(code: account.currency)))
                    infoRow(title: StringConstants.transparencyFrom, value: account.transparencyFrom.formattedDateTime())
                    infoRow(title: StringConstants.transparencyTo, value: account.transparencyTo.formattedDateTime())
                    infoRow(title: StringConstants.actualizationDate, value: account.actualizationDate.formattedDateTime())
                    infoRow(title: StringConstants.accountDescription, value: account.description)
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
