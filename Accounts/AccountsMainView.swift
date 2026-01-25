//
//  AccountsMainView.swift
//  Accounts
//
//  Created by Martin Hrbáček on 07.12.2025.
//

import SwiftUI

struct AccountsMainView: View {
    
    @AppStorage("isDarkOn") private var isDarkOn: Bool = false
    
    @State private var vm: AccountsListModelView
    
    init(fetchService: FetchServiceProtocol = FetchService()) {
        _vm = State(wrappedValue: AccountsListModelView(fetchService: fetchService))
    }
    
    @State private var searchText: String = ""
    @State private var alphabetical: Bool = true
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView(StringConstants.loading)
            } else if let errorMessage = vm.errorMessage {
                VStack {
                    Image(systemName: StringConstants.exclamationMarkTriangle)
                        .foregroundStyle(.orange)
                        .bold()
                        .font(.system(size: 28, design: .rounded))
                    Text(StringConstants.error)
                        .font(.system(size: 26, design: .rounded))
                        .bold()
                        .padding(5)
                    Text(errorMessage)
                        .font(.system(size: 22, design: .rounded))
                        .bold()
                        .padding(5)
                    Button {
                        Task {
                            await vm.loadAccounts()
                        }
                    } label: {
                        VStack {
                            Text(StringConstants.tryAgain)
                                .font(.system(size: 20, design: .rounded))
                                .bold()
                                .padding()
                            Image(systemName: StringConstants.arrowClockwise)
                                .font(.system(size: 20, design: .rounded))
                                .bold()
                        }
                    }
                }
                .multilineTextAlignment(.center)
                .padding()
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
                    
                    .navigationDestination(for: AccountsViewModel.self) { account in
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

#Preview("Mock Data") {
    struct MockService: FetchServiceProtocol {
        func fetchAccounts() async throws -> [Account] {
            return [
            Accounts.Account(
                accountNumber: "000182-0388063349",
                bankCode: "0800",
                transparencyFrom: "2013-12-18T00:00:00",
                transparencyTo: "3000-01-01T00:00:00",
                publicationTo: "3000-01-01T00:00:00",
                actualizationDate: "2018-01-17T13:01:34",
                balance: 0,
                currency: "CZK",
                name: "Město Černošice",
                description: "Veřejná sbírka - sportovní hala",
                iban: "CZ07 0800 0001 8203 8806 3349"
            )
            ]
        }
    }
    return AccountsMainView(fetchService: MockService())
}

#Preview("Error State") {
    struct ErrorService: FetchServiceProtocol {
        func fetchAccounts() async throws -> [Account] {
            throw NetworkError.httpError(404)
        }
    }
    return AccountsMainView(fetchService: ErrorService())
}
