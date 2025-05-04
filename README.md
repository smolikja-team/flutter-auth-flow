# Firebase Auth Flow

Flutter widget package for handling a Firebase Authentication Flow. This package provides a complete authentication flow for Firebase Authentication, including login, registration, and email verification.

![Firebase Auth Flow preview](assets/docs/preview.jpg "preview")

## Features

- Email and password authentication
- Email verification flow
- Customizable UI components
- Localization support (English and Czech)
- Responsive design
- Error handling with user-friendly messages
- Text styles without colors (colors are added using copyWith)

## Getting started

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  firebase_auth_flow:
    git:
      url: https://github.com/smolikja/firebase-auth-flow
      ref: 1.3.1  # Use the latest version
```

### Setup Localization

Add Firebase Auth Flow's `localizationsDelegates` to your `MaterialApp` and ensure your app's supported locales are also supported by `firebase_auth_flow`.

<details>
<summary>Localization Setup Example</summary>

```dart
import 'package:firebase_auth_flow/firebase_auth_flow.dart'
    as firebase_auth_flow;

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
        ...firebase_auth_flow.AppLocalizations.localizationsDelegates,
      ];

  Iterable<Locale> get _supportedLocales {
    // Make sure app's supported locales are also firebase_auth_flow's supported locales
    for (final loca in AppLocalizations.supportedLocales) {
      if (!firebase_auth_flow.AppLocalizations.supportedLocales
          .contains(loca)) {
        throw UnsupportedError(
          "Not all app's supported locales are also firebase_auth_flow's supported locales. Head to firebase_auth_flow's doc.",
        );
      }
    }
    return AppLocalizations.supportedLocales;
  }
}
```

</details>

## Core Components

### FirebaseAuthFlowProvider

Authentication provider type:

- `email` - Email and password authentication

### FirebaseAuthFlowDependencies

Configuration object for the Firebase Auth Flow:

- `provider` - The type of authentication provider
- `activityIndicator` - Widget that indicates loading activity
- `loginAboutText` - String for help/support link
- `onLoginAboutTextPressed` - Action for the help/support link
- `onPrivacyPolicyPressed` - Action for showing privacy policy
- `onLoginPressed` - Action for handling login
- `onRegisterPressed` - Action for handling registration
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

### FirebaseAuthFlowState

Flow state enum:

- `login` - Shows the login page
- `emailVerification` - Shows the email verification page

## Usage Example

```dart
final FirebaseAuthFlowState firebaseAuthFlowState;

// Determine the initial state based on user verification status
if (FirebaseAuth.instance.currentUser?.emailVerified == null) {
    firebaseAuthFlowState = FirebaseAuthFlowState.login;
} else {
    firebaseAuthFlowState = FirebaseAuthFlowState.emailVerification;
}

// Create the Firebase Auth Flow widget
return FirebaseAuthFlow(
    FirebaseAuthFlowDependencies(
        provider: FirebaseAuthFlowProvider.email,
        activityIndicator: const PlatformActivityIndicator(),
        loginAboutText: 'About',
        onLoginAboutTextPressed: () {}, // Navigate to "about" screen
        onPrivacyPolicyPressed: () {}, // Navigate to privacy policy screen
        onLoginPressed: AuthenticationHelper().login,
        onRegisterPressed: AuthenticationHelper().registerEmail,
        onCheckVerificationPressed: AuthenticationHelper().checkEmailVerification,
        onResendVerificationPressed: AuthenticationHelper().resendEmailVerification,
        onLogoutPressed: AuthenticationHelper().logout,
        onLoggedIn: () => {}, // Action after user is logged in
        onLoggedOut: () => {}, // Action after user is logged out
        colorPrimary: Colors.blue, // Optional: customize colors
        colorOnPrimary: Colors.white,
    ),
    state: firebaseAuthFlowState,
);
```

<details>
<summary>AuthenticationHelper() example</summary>

``` dart

class AuthenticationHelper {
  factory AuthenticationHelper() {
    return _authenticationHelper;
  }

  AuthenticationHelper._internal();
  static final AuthenticationHelper _authenticationHelper =
      AuthenticationHelper._internal();

  User? get user => FirebaseAuth.instance.currentUser;
  bool? get isEmailVerified => user?.emailVerified;

  Future<void> registerEmail({
    required String email,
    required String password,
    required void Function({String? errorCode}) onRegisterDone,
  }) async {
    try {
      await _createFirebaseAccount(
        email: email,
        password: password,
      );
      await _sendEmailVerification();
      onRegisterDone();
    } catch (errorCode) {
      onRegisterDone(
        errorCode: errorCode.toString(),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required void Function({String? errorCode, bool? isEmailVerified})
        onLoginDone,
  }) async {
    try {
      await _signIntoFirebase(email: email, password: password);
      onLoginDone(isEmailVerified: isEmailVerified);
    } catch (errorCode) {
      onLoginDone(
        errorCode: errorCode.toString(),
      );
    }
  }

  Future<void> logout({
    required void Function({String? errorCode}) onLogoutDone,
  }) async {
    try {
      await FirebaseAuth.instance.signOut();
      await user?.reload();
      Logging.log.info('$runtimeType -> logOut: logged out');
      onLogoutDone();
    } catch (errorCode, stackTrace) {
      Logging.log.severe(
        '$runtimeType -> logOut: ${errorCode.toString()}',
        errorCode,
        stackTrace,
      );
      onLogoutDone(
        errorCode: errorCode.toString(),
      );
    }
  }

  Future<void> checkEmailVerification({
    required void Function({String? errorCode, bool? isEmailVerified})
        onCheckDone,
  }) async {
    try {
      await user?.reload();
      if (isEmailVerified != true) {
        Logging.log.info(
          '$runtimeType -> checkEmailVerification: email is not verified',
        );
        onCheckDone(errorCode: FirebaseAuthFlowError.emailNotVerified.code);
      } else {
        Logging.log.info(
          '$runtimeType -> checkEmailVerification: email is verified',
        );
        onCheckDone(isEmailVerified: true);
      }
    } catch (errorCode, stackTrace) {
      Logging.log.severe(
        '$runtimeType -> checkEmailConfirmation: ${errorCode.toString()}',
        errorCode,
        stackTrace,
      );
      onCheckDone(
        errorCode: errorCode.toString(),
      );
    }
  }

  Future<void> resendEmailVerification({
    required void Function({String? errorCode}) onResendDone,
  }) async {
    try {
      await _sendEmailVerification();
      Logging.log.info(
        '$runtimeType -> resendEmailConfirmation: email confirmation resent',
      );
      onResendDone();
    } catch (errorCode, stackTrace) {
      Logging.log.severe(
        '$runtimeType -> resendEmailConfirmation: ${errorCode.toString()}',
        errorCode,
        stackTrace,
      );
      onResendDone(
        errorCode: errorCode.toString(),
      );
    }
  }

  Future<void> _sendEmailVerification() async {
    final currentUser = user;

    if (currentUser != null && !currentUser.emailVerified) {
      await currentUser.sendEmailVerification();
      await user?.reload();
      Logging.log.info('$runtimeType -> sendEmailVerification: sent');
    } else {
      return Future.error(FirebaseAuthFlowError.userLoggedOut.code);
    }
  }

  Future<void> _createFirebaseAccount({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user?.reload();
      Logging.log.info('$runtimeType -> _createFirebaseAccount: created');
    } on FirebaseAuthException catch (e, stackTrace) {
      Logging.log.severe(
        '$runtimeType -> _createFirebaseAccountOut: ${e.toString()}',
        e,
        stackTrace,
      );
      return Future.error(e.code);
    } catch (e, stackTrace) {
      Logging.log.severe(
        '$runtimeType -> _createFirebaseAccountOut: ${e.toString()}',
        e,
        stackTrace,
      );
      return Future.error(FirebaseAuthFlowError.universal.code);
    }
  }

  Future<void> _signIntoFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await user?.reload();
      Logging.log.info('$runtimeType -> _signIntoFirebase: signed in');
    } on FirebaseAuthException catch (e, stackTrace) {
      Logging.log.severe(
        '$runtimeType -> _signIntoFirebase: ${e.toString()}',
        e,
        stackTrace,
      );
      return Future.error(e.code);
    } catch (e, stackTrace) {
      Logging.log.severe(
        '$runtimeType -> _signIntoFirebase: ${e.toString()}',
        e,
        stackTrace,
      );
      return Future.error(FirebaseAuthFlowError.universal.code);
    }
  }
}
```

</details>

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
