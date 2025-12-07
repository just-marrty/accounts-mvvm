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
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Account name:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.name)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Account number:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.accountNumber)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("IBAN:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.iban)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Account currency:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.currency)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Account balance:")
                        .font(.system(size: 18))
                        .bold()
                    Text("\(account.balance.formatted())")
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Transparency from:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.transparencyFrom)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Transparency to:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.transparencyTo)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Actualization date:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.actualizationDate)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Account description:")
                        .font(.system(size: 18))
                        .bold()
                    Text(account.description)
                        .font(.system(size: 18))
                }
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle(account.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        AccountView(account: .sampleAccount)
    }
}
