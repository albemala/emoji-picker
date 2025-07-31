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

### User Experience
- **Copy & Paste Integration**: One-click copying to system clipboard
- **Fast Search**: Real-time fuzzy search with keyword matching
- **Keyboard Shortcuts**: 
  - `Cmd/Ctrl+F`: Focus search field
  - Arrow keys: Navigate between characters
  - `Cmd/Ctrl+C`: Copy selected character
- **Theme Support**: Light and dark theme options
- **Offline Operation**: Full functionality without internet connection

### Privacy & Performance
- **Privacy-Friendly**: No personal data collection or tracking
- **Local Data Storage**: All character data stored locally for fast access
- **Cross-Platform Consistency**: Uniform experience across all supported platforms

## Technical Stack

### Framework & Language
- **Flutter**: >=3.24.0
- **Dart**: >=3.5.0 <4.0.0
- **Target SDK**: Latest stable Flutter release

### State Management
- **Architecture Pattern**: BLoC (Business Logic Component) pattern
- **Primary Library**: `flutter_bloc` ^8.1.6
- **State Utilities**: `equatable` ^2.0.7, `fast_immutable_collections` ^11.0.0

### Key Dependencies

#### UI & Theming
- `flex_color_scheme` ^8.0.2 - Advanced theming system
- `google_fonts` ^6.2.1 - Typography and font management
- `cupertino_icons` ^1.0.8 - iOS-style icons
- `sliver_tools` ^0.2.12 - Advanced scrollable layouts

#### Search & Data Processing
- `fuzzywuzzy` ^1.2.0 - Fuzzy string matching for search
- `easy_debounce` ^2.0.3 - Search input debouncing
- `collection` ^1.18.0 - Data structure utilities

#### System Integration
- `clipboard` ^0.1.3 - Clipboard operations
- `share_plus` ^10.1.2 - Native sharing functionality
- `url_launcher` ^6.3.1 - External URL handling
- `shared_preferences` ^2.3.5 - Local data persistence

#### Platform Services
- `package_info_plus` ^8.1.1 - App metadata access
- `device_info_plus` ^11.1.1 - Device information
- `in_app_review` ^2.0.10 - App store review prompts

### Architecture Patterns

#### BLoC Controllers
- **GlyphsDataController**: Manages emoji, symbol, and kaomoji data loading
- **SearchGlyphsDataController**: Handles search functionality and filtering
- **PreferencesDataController**: User preferences and settings management
- **SelectedGlyphDataController**: Current character selection state
- **SelectedTabDataController**: Navigation and tab state management
- **AppViewController**: Application-level state and theme management

#### Data Flow
- Immutable state management using `fast_immutable_collections`
- Event-driven architecture with clear separation of concerns
- Reactive UI updates through BLoC pattern implementation

## Project Structure

### Core Application (`lib/`)

#### Application Layer
- `app/` - Application configuration, main view, and global definitions
  - `defines.dart` - App constants and configuration values
  - `view.dart` - Main application widget and theme setup
  - `view-controller.dart` - Application-level state management

#### Feature Modules
- `glyph-data/` - Character data management and loading
- `search/` - Search functionality and filtering logic
- `preferences/` - User settings and preferences handling
- `selected-glyph/` - Character selection state management
- `selected-tab/` - Navigation and tab management
- `glyph-details/` - Character detail view and interactions
- `glyph-tile/` - Individual character display components
- `glyphs/` - Character grid and list views

#### Shared Components
- `widgets/` - Reusable UI components
- `shortcuts/` - Keyboard shortcut definitions and actions
- `local-store/` - Local data persistence layer
- `urls/` - URL handling and external link management

#### Utilities
- `analytics.dart` - Usage analytics (privacy-compliant)
- `clipboard.dart` - Clipboard integration utilities
- `feedback.dart` - User feedback and support systems
- `routing.dart` - Navigation and dialog management
- `share.dart` - Content sharing functionality
- `theme.dart` - Theme definitions and styling
- `math.dart` - Mathematical utilities
- `string.dart` - String processing helpers

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

### Primary Platforms
- **iOS**: Native iOS application via App Store
- **Android**: Native Android application via Google Play Store
- **Web**: Progressive Web App accessible via browsers
- **macOS**: Native macOS application via Mac App Store
- **Windows**: Native Windows application via Microsoft Store
- **Linux**: Snap package distribution (planned)

### Platform-Specific Features
- **Mobile**: Touch-optimized interface with haptic feedback
- **Desktop**: Keyboard shortcuts and window management
- **Web**: Responsive design with PWA capabilities
- **Cross-Platform**: Consistent UI/UX across all platforms

### Distribution Channels
- Official app stores for each platform
- Direct download from GitHub releases
- Web application hosted at ejimo-app.web.app

## Development Information

### Build Requirements
- Flutter SDK >=3.24.0
- Dart SDK >=3.5.0
- Platform-specific development tools (Xcode for iOS/macOS, Android Studio for Android)

### Key Configuration Files
- `pubspec.yaml` - Dependencies, assets, and build configuration
- `analysis_options.yaml` - Code quality and linting rules
- `firebase.json` - Web hosting configuration
- `codemagic.yaml` - CI/CD pipeline configuration

### Data Management
- **Local Storage**: Character data loaded from JSON assets
- **Preferences**: User settings persisted via SharedPreferences
- **No External APIs**: Fully offline operation with local data sources

### Development Workflow
- **State Management**: BLoC pattern with immutable state
- **Code Quality**: Very Good Analysis linting rules
- **Testing**: Unit tests with golden screenshot testing
- **Build Automation**: Platform-specific build scripts in `scripts/` directory
- **CI/CD**: Automated builds and deployments via Codemagic

### Performance Considerations
- **Lazy Loading**: BLoC providers configured for optimal initialization
- **Efficient Search**: Debounced search with fuzzy matching algorithms
- **Memory Management**: Immutable collections for efficient state updates
- **Font Optimization**: Runtime font fetching disabled for performance
