//
//  AccountView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import SwiftUI

struct AccountView: View {
    
    let account: AccountViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    infoRow(title: "Account name:", value: account.name)
                    infoRow(title: "Account number:", value: account.accountNumber)
                    infoRow(title: "IBAN:", value: account.iban)
                    infoRow(title: "Account currency:", value: account.currency)
                    infoRow(title: "Account balance:", value: "\(account.balance.formatted())")
                    infoRow(title: "Transparency from:", value: account.transparencyFrom)
                    infoRow(title: "Transparency to:", value: account.transparencyTo)
                    infoRow(title: "Actualization date:", value: account.actualizationDate)
                    infoRow(title: "Account description:", value: account.description)
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
        AccountView(account: .sampleAccount)
    }
}
