# Accounts

A SwiftUI application for browsing and exploring transparent bank accounts with detailed information fetched from Erste Group Public Transparent Accounts API.

## Features

- Browse a list of transparent bank accounts with their basic information
- Search functionality to filter accounts by name
- Real-time search filtering with smooth animations
- Light and dark mode toggle with persistent preference
- Alphabetical sorting toggle for account list
- Loading states and error handling with retry functionality
- Clean and modern UI with SwiftUI
- Detailed account view with comprehensive information

## Architecture

The project demonstrates modern SwiftUI patterns and MVVM architecture:

### Model

- **TransparencyAccount** - Decodable wrapper model representing the root JSON object from API
  - Contains nested `Account` struct representing individual account data
  - Maps only necessary keys from JSON response
  - Uses explicit `CodingKeys` enum for selective JSON decoding
  - Typealias `Account = TransparencyAccount.Account` for simplified type references

- **Account** - Nested struct representing a single transparent bank account
  - Includes account number, bank code, IBAN, balance, currency, name, description
  - Contains transparency period dates and actualization information
  - All properties are optional to handle missing JSON values gracefully
  - Conforms to `Decodable` and `Hashable` for JSON parsing and list operations

### Service

- **FetchService** - Fetches and decodes account data from Erste Group API
  - Uses URLSession with async/await for network requests
  - Custom error handling with `NetworkError` enum
  - Fetches data from Erste Group Public Transparent Accounts API sandbox endpoint
  - Uses JSONDecoder for parsing API responses
  - Requires API key authentication via `web-api-key` header
  - Extracts nested accounts array from `TransparencyAccount` wrapper

### ViewModel

- **AccountListModelView** - Manages application state and business logic
  - Uses `@Observable` macro for reactive UI updates
  - `@MainActor` for thread-safe UI updates
  - Dependency injection via initializer (receives `FetchService`)
  - Search functionality with case-insensitive filtering
  - Sorting functionality (alphabetical ascending/descending toggle)
  - Loading and error state management

- **AccountViewModel** - Presentation model wrapping `Account`
  - Conforms to `Identifiable` and `Hashable` for SwiftUI list support
  - Provides computed properties for view display with fallback values
  - Handles optional account properties with default values ("N/A" for strings, 0.0 for balance)
  - Separates domain model from presentation concerns
  - Trims whitespace from name values for clean UI display

### Views

- **ContentView** - Main container with searchable account list, dark mode toggle, and sorting
  - Uses `@AppStorage` for persistent dark mode preference
  - Real-time search filtering with `searchable` modifier
  - `NavigationStack` for navigation
  - Loading, error, and content states with appropriate UI
  - Toolbar buttons for theme switching and alphabetical sorting
  - Displays account name and currency in list view

- **AccountView** - Detailed view for individual account information
  - Scrollable detail view showing all account properties
  - Displays account number, IBAN, currency, balance, transparency dates
  - Shows account name, description, and actualization date
  - Clean layout with reusable `infoRow` helper method for consistent formatting
  - Each information row uses a private helper function to eliminate code duplication
  - Navigation title with account name

## Dependency Injection

The project uses constructor-based dependency injection:

- `AccountListModelView` receives `FetchService` as a dependency through its initializer
- This allows for easy testing and swapping implementations
- `FetchService` is injected in `ContentView` when creating the ViewModel
- Promotes loose coupling and testability

## State Management

- `@State` for local view state (search text, ViewModel instance, sorting toggle)
- `@AppStorage` for persistent dark mode preference
- `@Observable` macro for reactive ViewModel updates
- Reactive filtering with `searchable` modifier and computed properties
- State-based sorting with toggle mechanism

## Secrets Management

- **Secrets.swift** - Provides access to API keys via Bundle info dictionary
- **Secrets.xcconfig** - Build configuration file storing API key securely
- API key stored in `ACCOUNTS_API_KEY` build setting
- Fatal error if API key is missing to ensure proper configuration

## Technologies

- **SwiftUI** - Modern declarative UI framework
- **Async/Await** - Asynchronous data fetching from API using modern Swift concurrency
- **REST API** - Integration with Erste Group Public Transparent Accounts API
- **NavigationStack** - Programmatic navigation
- **JSON Decoding** - Custom Decodable implementation with nested structures and CodingKeys
- **Searchable** - Built-in search functionality with real-time filtering
- **AppStorage** - Persistent user preferences for theme
- **Observable** - Using `@Observable` macro for reactive UI updates
- **Dependency Injection** - Constructor-based DI for testability and flexibility
- **Animation** - Smooth transitions with default SwiftUI animations
- **URLRequest** - Custom request configuration with API key header authentication

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- Erste Group API key (configured in Secrets.xcconfig)

## Credits

This application uses the [Erste Group Public Transparent Accounts API](https://developers.erstegroup.com/) provided by Erste Group. The API provides access to public transparent accounts data, allowing users to browse and explore transparent bank accounts with detailed information.

The Public Transparent Accounts API enables access to publicly available transparent account information, including account details, balances, and transparency periods for accounts that are required by law to be publicly accessible.

For more information about the API and Erste Group's developer resources, visit [developers.erstegroup.com](https://developers.erstegroup.com/).
   
