# Accounts
A SwiftUI application for browsing and exploring transparent bank accounts with detailed information fetched from Erste Group Public Transparent Accounts API.

## Features
- Browse a list of transparent bank accounts with their basic information
- Search functionality to filter accounts by name
- Real-time search filtering with smooth animations
- Automatic alphabetical sorting on load
- Light and dark mode toggle with persistent preference
- Alphabetical sorting toggle for account list
- Loading states and error handling with retry functionality
- Clean and modern UI with SwiftUI
- Detailed account view with comprehensive information
- Dynamic currency formatting based on account data
- ISO8601 date formatting with user-friendly display
- Protocol-based dependency injection for testability
- Thread-safe state management with @MainActor

## Architecture
The project demonstrates modern SwiftUI patterns and MVVM architecture with protocol-oriented design:

### Model
**AccountWrapper** - Decodable wrapper model representing the root JSON object from API
- Contains nested Account struct representing individual account data
- Maps only necessary keys from JSON response
- Uses explicit CodingKeys enum for selective JSON decoding
- Typealias `Account = AccountWrapper.Account` for simplified type references

**Account** - Nested struct representing a single transparent bank account
- Includes account number, bank code, IBAN, balance, currency, name, description
- Contains transparency period dates and actualization information
- All properties are optional to handle missing JSON values gracefully
- Conforms to Decodable and Hashable for JSON parsing and list operations

### Protocol
**FetchServiceProtocol** - Protocol defining account fetching contract
- Defines async `fetchAccounts()` method
- Conforms to `Sendable` for thread safety
- Enables dependency injection with protocol-based design
- Allows easy mocking for testing and previews

### Service
**FetchService** - Implementation of FetchServiceProtocol
- Conforms to `FetchServiceProtocol` for protocol-based dependency injection
- Uses URLSession with async/await for network requests
- Custom error handling with `NetworkError` enum
- Comprehensive error logging with print statements for debugging
- Fetches data from Erste Group Public Transparent Accounts API sandbox endpoint
- Uses JSONDecoder with snake_case conversion for parsing API responses
- Requires API key authentication via web-api-key header
- Extracts nested accounts array from AccountWrapper

### ViewModel
**AccountsListModelView** - Manages application state and business logic
- Uses `@Observable` macro for reactive UI updates
- `@MainActor` for thread-safe UI updates
- Protocol-based dependency injection via initializer (receives `FetchServiceProtocol`)
- Search functionality with case-insensitive filtering
- Sorting functionality (alphabetical ascending/descending toggle)
- Automatic alphabetical sorting on data load
- Loading and error state management with user-friendly error messages

**AccountsViewModel** - Presentation model wrapping Account
- Conforms to Identifiable and Hashable for SwiftUI list support
- Provides computed properties for view display with fallback values
- Handles optional account properties with constants from `StringConstants`
- `formattedBalance` property for currency formatting in ViewModel layer
- Separates domain model from presentation concerns
- Trims whitespace from name values for clean UI display

### Views
**AccountsMainView** - Main container with searchable account list, dark mode toggle, and sorting
- Uses `@AppStorage` for persistent dark mode preference
- Real-time search filtering with searchable modifier
- NavigationStack for navigation
- Loading, error, and content states with appropriate UI
- Toolbar buttons for theme switching and alphabetical sorting
- Displays account name and currency in list view
- Asynchronous dark mode toggle for smooth transitions
- Dependency injection with default `FetchService()` implementation
- Mock implementations in previews for testing different states

**AccountsDetailView** - Detailed view for individual account information
- Scrollable detail view showing all account properties
- Displays account number, IBAN, currency with dynamic formatting
- Shows formatted balance from ViewModel's `formattedBalance` property
- Transparency dates and actualization date with ISO8601 formatting
- Shows account name and description
- Clean layout with reusable `infoRow` helper method for consistent formatting
- Each information row uses a private helper function to eliminate code duplication
- Navigation title with account name

### Extensions
**DateTimeFormatter+Extensions** - String extension for date formatting
- Converts ISO8601 date strings to user-friendly format
- Handles multiple ISO8601 formats (with/without fractional seconds)
- Fallback handling for API dates without timezone information
- Returns abbreviated date and shortened time format

**AccountViewModel+Extensions** - Sample data for previews
- Provides `sampleAccountsDetailView` for SwiftUI previews
- Includes realistic test data matching API response structure

### Constants
**Strings** - Centralized string management
- All user-facing strings in one place for easy maintenance
- Error messages and loading states
- View labels and placeholders (account details, navigation titles)
- System image names for SF Symbols
- Navigation titles and search prompts
- Fallback values (N/A, unknown currency)
- Improves maintainability and enables easy localization
- Organized by feature with MARK comments

**APIConstants** - API configuration constants

- Stores base URL, endpoint paths and header
- Separates network configuration from business logic
- Single source of truth for API endpoints

## Dependency Injection
The project uses protocol-based constructor dependency injection:
- `FetchServiceProtocol` defines the contract for data fetching
- `AccountsListModelView` receives `FetchServiceProtocol` as a dependency through its initializer
- This allows for easy testing and swapping implementations
- `FetchService` is injected in `AccountsMainView` when creating the ViewModel
- Promotes loose coupling and testability
- Mock implementations (`MockService`, `ErrorService`) in previews demonstrate testability

## State Management
- `@State` for local view state (search text, ViewModel instance, sorting toggle)
- `@AppStorage` for persistent dark mode preference
- `@Observable` macro for reactive ViewModel updates
- `@MainActor` ensures all UI updates happen on the main thread
- Reactive filtering with searchable modifier and computed properties
- State-based sorting with toggle mechanism
- Asynchronous state updates for smooth UI transitions

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
- **Observable** - Using @Observable macro for reactive UI updates
- **@MainActor** - Thread-safe UI updates
- **Protocol-Oriented Programming** - FetchServiceProtocol for dependency injection
- **Sendable** - Thread-safe protocol conformance
- **Animation** - Smooth transitions with default SwiftUI animations
- **URLRequest** - Custom request configuration with API key header authentication
- **Swift Extensions** - Custom String extensions for date formatting
- **Currency Formatting** - Dynamic currency display based on API data in ViewModel

## Requirements
- iOS 18.0+
- Xcode 18.0+
- Swift 6+
- Erste Group API key (configured in Secrets.xcconfig)

## Credits
This application uses the Erste Group Public Transparent Accounts API provided by Erste Group. The API provides access to public transparent accounts data, allowing users to browse and explore transparent bank accounts with detailed information.

The Public Transparent Accounts API enables access to publicly available transparent account information, including account details, balances, and transparency periods for accounts that are required by law to be publicly accessible.

For more information about the API and Erste Group's developer resources, visit [developers.erstegroup.com](https://developers.erstegroup.com).
