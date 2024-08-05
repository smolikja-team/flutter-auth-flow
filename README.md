<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Firebase Auth Flow

Flutter widget package for handling a Firebase Authentication Flow.

## FirebaseAuthFlowDependencies

- `provider` => The type of authentication provider,
- `activityIndicator` => Widget that indicates some activity,
- `loginAboutText` => String navigating to help/support,
- `onLoginAboutText` => action for the help/support,
- `disabledOpacity` => opacity of disabled,
- `borderRadius` => border radius.

## Getting started

- Add Firebase Auth Flow's `localizationsDelegates` to your `MaterialApp`'s ones,
- make sure that app's supported locales are also `firebase_auth_flow`'s supported locales. If not, contribute to Firebase Auth Flow, please.

``` dart
import 'package:firebase_auth_flow/l10n/app_localizations.dart'
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

### Usage

``` dart
FirebaseAuthFlowDependencies(
    provider: FirebaseAuthFlowProvider.email,
    activityIndicator: const PlatformActivityIndicator(),
    loginAboutText: 'Need help',
    onLoginAboutText: () => print('Need help tapped'),
)
```

## Contribution

### build runner

`flutter packages pub run build_runner build --verbose --delete-conflicting-outputs`

### loca gen

`flutter gen-l10n`
