//
//  ContentView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkOn") private var isDarkOn: Bool = false
    
    @State private var vm = AccountListModelView(fetchService: FetchService())
    
    @State private var searchText: String = ""
    @State private var alphabetical: Bool = false
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = vm.errorMessage {
                VStack {
                    Text("Error")
                        .font(.headline)
                    Text(errorMessage)
                        .foregroundColor(.secondary)
                    Button("Try again") {
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
                    .navigationTitle("Accounts")
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                    
                    .navigationDestination(for: AccountViewModel.self) { account in
                        // AccountView
                        AccountView(account: account)
                    }
                    .searchable(text: $searchText, prompt: "Search account")
                    .animation(.default, value: searchText)
                    
                    .navigationBarItems(trailing: Button(action: {
                        isDarkOn.toggle()
                    }, label: {
                        Image(systemName: isDarkOn ? "sun.max.fill" : "moon.fill")
                    }))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                alphabetical.toggle()
                                vm.sort(by: alphabetical)
                            } label: {
                                Image(systemName: alphabetical ? "textformat.abc" : "textformat")
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
    ContentView()
}
