//
//  AccountsMainView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import SwiftUI

struct AccountsMainView: View {
    
    @AppStorage("isDarkOn") private var isDarkOn: Bool = false
    
    @State private var vm = AccountListModelView(fetchService: FetchService())
    
    @State private var searchText: String = ""
    @State private var alphabetical: Bool = true
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView(StringConstants.loading)
            } else if let errorMessage = vm.errorMessage {
                VStack {
                    Text(StringConstants.error)
                        .font(.headline)
                    Text(errorMessage)
                        .foregroundColor(.secondary)
                    Button(StringConstants.tryAgain) {
                        Task {
                            await vm.loadAccounts()
                        }
                    }
                }
            } else {
                NavigationStack {
                    List(vm.search(for: searchText)) { account in
                        NavigationLink(value: account) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(account.name)
                                    .font(.system(size: 18))
                                    .bold()
                                Text(account.currency)
                                    .font(.system(size: 16))
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle(StringConstants.navigationTitle)
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                    
                    .navigationDestination(for: AccountViewModel.self) { account in
                        AccountsDetailView(account: account)
                    }
                    .searchable(text: $searchText, prompt: StringConstants.searchAccount)
                    .animation(.default, value: searchText)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                alphabetical.toggle()
                                vm.sort(by: alphabetical)
                            } label: {
                                Image(systemName: alphabetical ? StringConstants.textFormatABC : StringConstants.textFormat)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                Task {
                                    isDarkOn.toggle()
                                }
                            } label: {
                                Image(systemName: isDarkOn ? StringConstants.sunMaxFill : StringConstants.moonFill)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .preferredColorScheme(isDarkOn ? .dark : .light)
        .tint(isDarkOn ? .white : .primary)
        .task {
            await vm.loadAccounts()
        }
    }
}

#Preview {
    AccountsMainView()
}
