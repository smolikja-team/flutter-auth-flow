# Flutter Auth Flow

A flexible Flutter widget package for handling authentication flows. This package provides a complete, customizable authentication UI that can work with any authentication provider (Firebase, Strapi, Supabase, Auth0, custom backends, etc.).

![Flutter Auth Flow preview](assets/docs/preview.jpg "preview")

## Features

- **Provider-agnostic** - Works with any authentication backend
- Email and password authentication UI
- Email verification flow
- **Password reset functionality** - Built-in reset password support
- Customizable UI components
- Localization support (English and Czech)
- Responsive design
- User-friendly error and success messages
- Clean separation of UI and business logic
- Text styles without colors (colors are added using copyWith)

## Getting started

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_auth_flow:
    git:
      url: https://github.com/smolikja/flutter-auth-flow
      ref: main  # Use the latest version
```

### Setup Localization

Add Flutter Auth Flow's `localizationsDelegates` to your `MaterialApp` and ensure your app's supported locales are also supported by `flutter_auth_flow`.

<details>
<summary>Localization Setup Example</summary>

```dart
import 'package:flutter_auth_flow/flutter_auth_flow.dart'
    as flutter_auth_flow;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Flavors.title,
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: _supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter,
    );
  }

  Iterable<LocalizationsDelegate<dynamic>>? get _localizationsDelegates => [
        ...AppLocalizations.localizationsDelegates,
        ...flutter_auth_flow.AppLocalizations.localizationsDelegates,
      ];

  Iterable<Locale> get _supportedLocales {
    // Make sure app's supported locales are also flutter_auth_flow's supported locales
    for (final loca in AppLocalizations.supportedLocales) {
      if (!flutter_auth_flow.AppLocalizations.supportedLocales
          .contains(loca)) {
        throw UnsupportedError(
          "Not all app's supported locales are also flutter_auth_flow's supported locales. Head to flutter_auth_flow's doc.",
        );
      }
    }
    return AppLocalizations.supportedLocales;
  }
}
```

</details>

## Core Components

### FlutterAuthFlowDependencies

Configuration object for the Flutter Auth Flow. This is where you provide your authentication logic:

- `activityIndicator` - Widget that indicates loading activity
- `loginAboutText` - String for help/support link
- `onLoginAboutTextPressed` - Action for the help/support link
- `onPrivacyPolicyPressed` - Action for showing privacy policy
- `onLoginPressed` - Action for handling login (your auth logic)
- `onRegisterPressed` - Action for handling registration (your auth logic)
- `onCheckVerificationPressed` - Action for checking email verification status
- `onResendVerificationPressed` - Action for resending verification email
- `onLogoutPressed` - Action for handling logout
- `onResetPasswordPressed` - Action for handling password reset requests
- `onLoggedIn` - Callback when user successfully logs in
- `onLoggedOut` - Callback when user logs out
- `disabledOpacity` - Optional opacity for disabled elements (default: 0.65)
- `borderRadius` - Optional border radius for UI elements (default: 12.0)
- `colorPrimary` - Optional primary color
- `colorOnPrimary` - Optional color for text/icons on primary color
- `colorSecondary` - Optional secondary color
- `colorOnSecondary` - Optional color for text/icons on secondary color
- `colorAbout` - Optional color for the about text
- `colorError` - Optional color for error messages
- `colorOnError` - Optional color for text on error background
- `colorSuccess` - Optional color for success messages
- `colorOnSuccess` - Optional color for text on success background

### FlutterAuthFlowState

Flow state enum:

- `login` - Shows the login page
- `emailVerification` - Shows the email verification page

## Usage Examples

### Basic Usage

```dart
final FlutterAuthFlowState authFlowState;

// Determine the initial state based on user verification status
if (yourAuthService.currentUser?.emailVerified == null) {
    authFlowState = FlutterAuthFlowState.login;
} else {
    authFlowState = FlutterAuthFlowState.emailVerification;
}

// Create the Flutter Auth Flow widget
return FlutterAuthFlow(
    FlutterAuthFlowDependencies(
        activityIndicator: const CircularProgressIndicator(),
        loginAboutText: 'About',
        onLoginAboutTextPressed: () {}, // Navigate to "about" screen
        onPrivacyPolicyPressed: () {}, // Navigate to privacy policy screen
        onLoginPressed: YourAuthService().login,
        onRegisterPressed: YourAuthService().register,
        onCheckVerificationPressed: YourAuthService().checkEmailVerification,
        onResendVerificationPressed: YourAuthService().resendEmailVerification,
        onLogoutPressed: YourAuthService().logout,
        onResetPasswordPressed: YourAuthService().resetPassword,
        onLoggedIn: () => {}, // Action after user is logged in
        onLoggedOut: () => {}, // Action after user is logged out
        colorPrimary: Colors.blue, // Optional: customize colors
        colorOnPrimary: Colors.white,
    ),
    state: authFlowState,
);
```

## Password Reset Feature

The package includes built-in password reset functionality. When users tap the "Forgotten Password" link on the login screen, your `onResetPasswordPressed` callback will be triggered with the entered email address.

### Implementation Example

```dart
onResetPasswordPressed: ({
  required String email,
  required void Function({String? errorMessage}) onResetDone,
}) async {
  try {
    await yourAuthService.sendPasswordResetEmail(email);
    onResetDone(); // Success - no error message
  } catch (e) {
    onResetDone(errorMessage: e.toString()); // Pass error message
  }
},
```

The package will automatically show success or error messages using customizable snackbars based on the result.

## Error Handling

The package provides consistent error handling through callback functions. When an error occurs, pass the error message to the completion callback:

- **Success**: Call the completion callback without parameters
- **Error**: Call the completion callback with `errorMessage` parameter

Error and success messages are displayed using customizable snackbars with colors from your `FlutterAuthFlowDependencies`.

## Migration from 2.x to 3.x

### Breaking Changes

1. **Package name**: `firebase_auth_flow` → `flutter_auth_flow`
2. **Class names**:
   - `FirebaseAuthFlow` → `FlutterAuthFlow`
   - `FirebaseAuthFlowDependencies` → `FlutterAuthFlowDependencies`
   - `FirebaseAuthFlowState` → `FlutterAuthFlowState`
3. **Removed**: `FirebaseAuthFlowProvider` enum (no longer needed)
4. **Added**: `onResetPasswordPressed` callback is now required

### Migration Steps

1. Update your `pubspec.yaml` dependency name
2. Update imports: `package:firebase_auth_flow` → `package:flutter_auth_flow`
3. Update class names in your code
4. Remove any references to `FirebaseAuthFlowProvider`
5. Add implementation for `onResetPasswordPressed` callback

## Development and Contribution

This section provides comprehensive guidance for developers working on or contributing to the Flutter Auth Flow package.

### Development Workflow

#### 1. Initial Setup

```bash
# Clone the repository
git clone https://github.com/smolikja/flutter-auth-flow.git
cd flutter-auth-flow

# Install dependencies
flutter pub get

# Generate initial code
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n
```

#### 2. Development Commands

**Code Generation** - Generate freezed models and riverpod providers:

```bash
# Generate code (run after modifying state classes or providers)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
flutter pub run build_runner watch --delete-conflicting-outputs
```

**Localization** - Generate localization files after modifying ARB files:

```bash
# Generate localization files
flutter gen-l10n

# This reads from l10n.yaml configuration:
# - Source: lib/src/l10n/intl_cs.arb (Czech template)
# - Output: lib/src/l10n/app_localizations.dart
```

**Testing**:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/flutter_widget_firebase_auth_test.dart
```

**Code Quality**:

```bash
# Analyze code for issues
flutter analyze

# Format code according to Dart style guide
dart format .

# Check for unused dependencies
flutter pub deps
```

### Project Structure

```text
lib/
├── flutter_auth_flow.dart          # Main library export file
└── src/
    ├── core/                       # Core utilities and widgets
    │   ├── extensions/             # Dart extensions
    │   ├── providers/              # Global state management
    │   ├── text_styles/            # Typography definitions
    │   └── widgets/                # Reusable UI components
    ├── features/                   # Feature-specific modules
    │   ├── login_page/             # Login/registration functionality
    │   └── email_verification_page/ # Email verification flow
    ├── l10n/                       # Generated localization files
    ├── flutter_auth_flow_dependencies.dart # Dependency injection
    └── flutter_auth_flow_state.dart        # Flow state definitions
```

### Development Guidelines

#### Text Styles

The package uses a consistent text styling approach:

- Text styles are defined without colors in the `TextStyles` class
- Colors are added when using the styles with `copyWith(color: ...)`
- Only text styles that are actually used in the codebase are kept in the `TextStyles` class
- This approach ensures color customization flexibility for implementers

#### State Management

- Uses **Riverpod** for state management with code generation
- State classes use **Freezed** for immutability and code generation
- Providers are generated using `@riverpod` annotation

#### Localization Workflow

1. **Add new strings** to `lib/src/l10n/intl_cs.arb` (Czech template)
2. **Run localization generation**: `flutter gen-l10n`
3. **Use in code** via `context.l10n.your_new_string`
4. **Configuration** is in `l10n.yaml`:
   - `arb-dir`: Points to ARB files location
   - `template-arb-file`: Czech file used as template
   - `output-localization-file`: Generated Dart file name

#### Code Quality Standards

The project uses strict linting rules defined in `analysis_options.yaml`:

- **Flutter Lints**: Extends `package:flutter_lints/flutter.yaml`
- **Required trailing commas**: Enforced for better Git diffs
- **Package imports**: Always use `package:` imports instead of relative
- **Const constructors**: Prefer const constructors where possible
- **Final variables**: Use final for immutable variables

#### Adding New Features

1. **Create feature folder** under `lib/src/features/`
2. **Follow the pattern**:

   ```text
   feature_name/
   ├── feature_page.dart           # Main page widget
   ├── feature_page_content.dart   # Page content
   ├── providers/                  # State management
   │   ├── feature_provider.dart
   │   ├── feature_state.dart
   │   └── feature_state.freezed.dart (generated)
   └── widgets/                    # Feature-specific widgets
   ```

3. **Add to main flow** in `FlutterAuthFlow` widget
4. **Update state enum** if needed
5. **Add localization strings** and regenerate
6. **Write tests** for new functionality

#### Testing Guidelines

- **Unit tests** for providers and business logic
- **Widget tests** for UI components
- **Integration tests** for complete flows
- **Test files** follow `*_test.dart` naming convention
- **Coverage** should be maintained above 80%

### Release Process

1. **Update version** in `pubspec.yaml`
2. **Update CHANGELOG.md** with new features and breaking changes
3. **Run full test suite**: `flutter test`
4. **Generate fresh code**: `flutter pub run build_runner build --delete-conflicting-outputs`
5. **Update documentation** if needed
6. **Create Git tag** with version number
7. **Update README** if API changes occurred

## License

This project is licensed under the MIT License - see the LICENSE file for details.
