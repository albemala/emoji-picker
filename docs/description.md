# Ejimo - Project Documentation

## Project Overview

**Ejimo** is a comprehensive emoji and symbol picker application built with Flutter. The app provides users with easy access to over 19,000 unicode characters including emojis, symbols, and kaomoji. Designed for designers, developers, writers, and general users, Ejimo simplifies the process of finding and copying unicode characters for any project, social media strategy, article, or presentation.

The application prioritizes user experience with fast search capabilities, offline functionality, and privacy-focused design. It serves as a universal tool for character discovery and clipboard integration across multiple platforms.

## Key Features

### Character Library
- **1800+ Emojis**: Comprehensive collection including smileys, people, animals, food, objects, and more
- **17000+ Symbols**: Extensive symbol library covering arrows, letters, punctuation, mathematical symbols, and special characters
- **Kaomoji Support**: Japanese emoticons and text-based expressions
- **Categorized Organization**: Characters organized by type for easy browsing
- **Favorites**: Users can save their most-used characters for quick access.
- **Recent Glyphs**: Automatically keeps track of recently used characters.

### User Experience
- **Copy & Paste Integration**: One-click copying to system clipboard
- **Fast Search**: Real-time fuzzy search with keyword matching
- **Keyboard Shortcuts**: 
  - `Cmd/Ctrl+F`: Focus search field
  - Arrow keys: Navigate between characters
  - `Cmd/Ctrl+C`: Copy selected character
- **Theme Support**: Light and dark theme options
- **Offline Operation**: Full functionality without internet connection

### Privacy
- **Privacy-Friendly**: No personal data collection or tracking
- **Local Data Storage**: All character data stored locally for fast access

## Technical Stack

### Framework & Language
- **Flutter**: >=3.24.0
- **Dart**: >=3.5.0 <4.0.0
- **Target SDK**: Latest stable Flutter release

### State Management
- **Architecture Pattern**: BLoC (Business Logic Component) pattern
- **Primary Library**: `flutter_bloc` ^8.1.6
- **State Utilities**: `equatable` ^2.0.7, `fast_immutable_collections` ^11.0.0

#### BLoC Controllers
- **GlyphsDataController**: Manages emoji, symbol, and kaomoji data loading
- **SearchGlyphsDataController**: Handles search functionality and filtering
- **PreferencesDataController**: User preferences and settings management
- **SelectedGlyphDataController**: Current character selection state
- **SelectedTabDataController**: Navigation and tab state management
- **AppViewController**: Application-level state and theme management
- **FavoritesDataController**: Manages favorite glyphs.
- **RecentDataController**: Manages recently used glyphs.

### Key Dependencies

#### State Management & Data
- `flutter_bloc` ^9.0.0 - Primary BLoC library
- `equatable` ^2.0.7 - State equality checking
- `fast_immutable_collections` ^11.0.4 - Immutable data structures
- `flutter_data_storage` 3.2.1 - Data persistence for BLoC/Cubit
- `collection` ^1.18.0 - Data structure utilities

#### UI & Theming
- `flex_color_scheme` ^8.0.2 - Advanced theming system
- `google_fonts` ^6.2.1 - Typography and font management
- `cupertino_icons` ^1.0.8 - iOS-style icons
- `sliver_tools` ^0.2.12 - Advanced scrollable layouts

#### Search
- `fuzzywuzzy` ^1.2.0 - Fuzzy string matching for search
- `easy_debounce` ^2.0.3 - Search input debouncing

#### System Integration & Platform Services
- `clipboard` ^0.1.3 - Clipboard operations
- `share_plus` ^10.1.2 - Native sharing functionality
- `url_launcher` ^6.3.1 - External URL handling
- `package_info_plus` ^8.1.1 - App metadata access
- `device_info_plus` ^11.1.1 - Device information
- `in_app_review` ^2.0.10 - App store review prompts

### Architecture Patterns

#### Data Flow
- Immutable state management using `fast_immutable_collections`
- Event-driven architecture with clear separation of concerns
- Reactive UI updates through BLoC pattern implementation

## Project Structure

### Core Application (`lib/`)

- **Application Layer** (`app/`): Main configuration, view, and global definitions.
- **Feature Modules**:
    - `glyph-data/`: Character data management.
    - `search/`: Search and filtering logic.
    - `preferences/`: User settings.
    - `favorites/`: Favorites management.
    - `recent/`: Recently used glyphs tracking.
    - `selected-glyph/`: Character selection state.
    - `selected-tab/`: Navigation and tab state.
    - `glyph-details/`: Character detail view.
    - `glyph-tile/`: Individual character components.
    - `glyphs/`: Character grid and list views.
- **Shared Components**:
    - `widgets/`: Reusable UI components.
    - `shortcuts/`: Keyboard shortcuts.
    - `local-store/`: Local data persistence.
    - `urls/`: URL handling.
- **Utilities**: Helper functions for analytics, clipboard, feedback, routing, sharing, theming, math, and string processing.

### Assets & Data (`assets/`)

#### Character Data
- `data/emoji.json` - Emoji definitions and metadata
- `data/symbols.json` - Symbol library and categorization
- `data/kaomoji.json` - Kaomoji collection and descriptions

#### Typography
- `fonts/NotoSans/` - Noto Sans font family for international character support
- `fonts/Noto_Color_Emoji/` - Color emoji font support
- `fonts/TitilliumWeb/` - Primary UI typography

#### Visual Assets
- `images/` - Application icons and promotional graphics

### Platform Configuration

#### Mobile Platforms
- `android/` - Android-specific configuration, build scripts, and metadata
- `ios/` - iOS configuration, provisioning, and App Store metadata

#### Desktop Platforms
- `windows/` - Windows application configuration and build setup
- `macos/` - macOS application bundle and store configuration
- `linux/` - Linux distribution and packaging configuration

#### Web Platform
- `web/` - Progressive Web App configuration and assets

### Development Tools
- `scripts/` - Build automation and deployment scripts
- `test/` - Unit tests and screenshot testing
- `keywords/` - App Store Optimization keyword lists

## Supported Platforms

- **iOS & Android**: Native mobile applications with touch-optimized UI.
- **macOS, Windows, & Linux**: Native desktop applications with keyboard shortcuts and window management.
- **Web**: Progressive Web App with responsive design.

### Distribution Channels
- Official app stores for each platform
- Direct download from GitHub releases
- Web application hosted at ejimo-app.web.app

## Development Information

### Build Requirements
- Flutter SDK >=3.24.0
- Dart SDK >=3.5.0
- Platform-specific development tools (Xcode, Android Studio)

### Configuration
- `pubspec.yaml`: Dependencies, assets, and build configuration.
- `analysis_options.yaml`: Code quality and linting rules.
- `firebase.json`: Web hosting configuration.
- `codemagic.yaml`: CI/CD pipeline configuration.

### Data Management
- Character data is loaded from local JSON assets.
- User preferences and other data are persisted using `flutter_data_storage`, which builds on top of `StoredCubit`.
- State is managed by `StoredCubit` classes, which automatically handle data persistence.
- The app operates fully offline with no external API dependencies.

### Workflow
- **State Management**: BLoC pattern with `StoredCubit` for automatic persistence.
- **Code Quality**: Very Good Analysis linting rules.
- **Testing**: Unit tests with golden screenshot testing.
- **CI/CD**: Automated builds and deployments via Codemagic and `scripts/` directory.
