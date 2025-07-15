# Flutter Auth Flow

A flexible Flutter widget package for handling authentication flows. This package provides a complete, customizable authentication UI that can work with any authentication provider (Firebase, Strapi, Supabase, Auth0, custom backends, etc.).

![Flutter Auth Flow preview](assets/docs/preview.jpg "preview")

## Features

- **Provider-agnostic** - Works with any authentication backend
- Email and password authentication UI
- Email verification flow
- Customizable UI components
- Localization support (English and Czech)
- Responsive design
- Comprehensive error handling with user-friendly messages
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
      ref: 3.0.0  # Use the latest version
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

### FlutterAuthFlowError

Standardized error codes that work with any authentication provider:

- `universal` - Generic error
- `weakPassword` - Password doesn't meet requirements
- `emailInUse` - Email already registered
- `userNotFound` - User doesn't exist
- `wrongPassword` - Invalid password
- `emailInvalid` - Invalid email format
- `passwordNotMatching` - Password confirmation doesn't match
- `operationNotAllowed` - Operation not supported
- `userDisabled` - User account disabled
- `invalidCredential` - Invalid credentials
- `emailNotVerified` - Email not verified
- `userLoggedOut` - User not logged in

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
        onLoggedIn: () => {}, // Action after user is logged in
        onLoggedOut: () => {}, // Action after user is logged out
        colorPrimary: Colors.blue, // Optional: customize colors
        colorOnPrimary: Colors.white,
    ),
    state: authFlowState,
);
```

### Firebase Implementation Example

<details>
<summary>Firebase AuthService Implementation</summary>

```dart
class FirebaseAuthService {
  User? get user => FirebaseAuth.instance.currentUser;
  bool? get isEmailVerified => user?.emailVerified;

  Future<void> register({
    required String email,
    required String password,
    required void Function({String? errorCode}) onRegisterDone,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user?.sendEmailVerification();
      onRegisterDone();
    } on FirebaseAuthException catch (e) {
      onRegisterDone(errorCode: e.code);
    } catch (e) {
      onRegisterDone(errorCode: 'auth-error');
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required void Function({String? errorCode, bool? isEmailVerified}) onLoginDone,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onLoginDone(isEmailVerified: isEmailVerified);
    } on FirebaseAuthException catch (e) {
      onLoginDone(errorCode: e.code);
    } catch (e) {
      onLoginDone(errorCode: 'auth-error');
    }
  }

  Future<void> logout({
    required void Function({String? errorCode}) onLogoutDone,
  }) async {
    try {
      await FirebaseAuth.instance.signOut();
      onLogoutDone();
    } catch (e) {
      onLogoutDone(errorCode: 'auth-error');
    }
  }

  Future<void> checkEmailVerification({
    required void Function({String? errorCode, bool? isEmailVerified}) onCheckDone,
  }) async {
    try {
      await user?.reload();
      if (isEmailVerified != true) {
        onCheckDone(errorCode: 'email-not-verified');
      } else {
        onCheckDone(isEmailVerified: true);
      }
    } catch (e) {
      onCheckDone(errorCode: 'auth-error');
    }
  }

  Future<void> resendEmailVerification({
    required void Function({String? errorCode}) onResendDone,
  }) async {
    try {
      await user?.sendEmailVerification();
      onResendDone();
    } catch (e) {
      onResendDone(errorCode: 'auth-error');
    }
  }
}
```

</details>

### Strapi Implementation Example

<details>
<summary>Strapi AuthService Implementation</summary>

```dart
class StrapiAuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://your-strapi-api.com'));
  
  Future<void> register({
    required String email,
    required String password,
    required void Function({String? errorCode}) onRegisterDone,
  }) async {
    try {
      final response = await _dio.post('/auth/local/register', data: {
        'username': email,
        'email': email,
        'password': password,
      });
      
      if (response.statusCode == 200) {
        onRegisterDone();
      } else {
        onRegisterDone(errorCode: 'auth-error');
      }
    } on DioException catch (e) {
      String errorCode = 'auth-error';
      if (e.response?.data['error']['message']?.contains('email') == true) {
        errorCode = 'email-in-use';
      }
      onRegisterDone(errorCode: errorCode);
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required void Function({String? errorCode, bool? isEmailVerified}) onLoginDone,
  }) async {
    try {
      final response = await _dio.post('/auth/local', data: {
        'identifier': email,
        'password': password,
      });
      
      if (response.statusCode == 200) {
        final user = response.data['user'];
        onLoginDone(isEmailVerified: user['confirmed'] ?? false);
      } else {
        onLoginDone(errorCode: 'auth-error');
      }
    } on DioException catch (e) {
      String errorCode = 'auth-error';
      if (e.response?.status == 400) {
        errorCode = 'invalid-credential';
      }
      onLoginDone(errorCode: errorCode);
    }
  }

  // ... implement other methods similarly
}
```

</details>

## Error Handling

The package uses standardized error codes that work across different authentication providers. Your authentication service should map provider-specific errors to these standard codes:

```dart
// Firebase -> Standard mapping
'weak-password' -> 'weak-password'
'email-already-in-use' -> 'email-in-use'
'user-not-found' -> 'user-not-found'
'wrong-password' -> 'wrong-password'
'invalid-email' -> 'email-invalid'

// Strapi -> Standard mapping
'Email already taken' -> 'email-in-use'
'Invalid credentials' -> 'invalid-credential'
// ... etc
```

## Migration from 2.x to 3.x

### Breaking Changes

1. **Package name**: `firebase_auth_flow` → `flutter_auth_flow`
2. **Class names**:
   - `FirebaseAuthFlow` → `FlutterAuthFlow`
   - `FirebaseAuthFlowDependencies` → `FlutterAuthFlowDependencies`
   - `FirebaseAuthFlowState` → `FlutterAuthFlowState`
   - `FirebaseAuthFlowError` → `FlutterAuthFlowError`
3. **Removed**: `FirebaseAuthFlowProvider` enum (no longer needed)
4. **Error codes**: Some error codes were generalized (e.g., `email-already-in-use` → `email-in-use`)

### Migration Steps

1. Update your `pubspec.yaml` dependency name
2. Update imports: `package:firebase_auth_flow` → `package:flutter_auth_flow`
3. Update class names in your code
4. Remove any references to `FirebaseAuthFlowProvider`
5. Update error code mappings if needed

## Development and Contribution

### Text Styles

The package uses a consistent text styling approach:

- Text styles are defined without colors in the `TextStyles` class
- Colors are added when using the styles with `copyWith(color: ...)`
- Only text styles that are actually used in the codebase are kept in the `TextStyles` class

### Code Generation

Generate code for freezed models and riverpod providers:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Localization

Generate localization files:

```bash
flutter gen-l10n
```

### Testing

Run tests to ensure everything works correctly:

```bash
flutter test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
