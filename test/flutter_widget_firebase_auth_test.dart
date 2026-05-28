import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders login form and submits typed credentials', (
    WidgetTester tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('cs'));
    final harness = _AuthFlowHarness();

    await _pumpAuthFlow(tester, harness);

    expect(find.text(l10n.auth_title_login), findsOneWidget);
    expect(find.text(l10n.auth_label_email), findsOneWidget);
    expect(find.text(l10n.auth_label_password), findsOneWidget);

    await tester.enterText(
      find.byType(TextField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextField).at(1), 'secret123');
    await tester.tap(
      find.widgetWithText(TextButton, l10n.auth_button_action_login),
    );
    await tester.pumpAndSettle();

    expect(harness.loginCalls, 1);
    expect(harness.loginEmail, 'user@example.com');
    expect(harness.loginPassword, 'secret123');
    expect(harness.loggedInCalls, 1);
  });

  testWidgets('switches to registration and submits matching passwords', (
    WidgetTester tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('cs'));
    final harness = _AuthFlowHarness();

    await _pumpAuthFlow(tester, harness);
    await tester.tap(
      find.widgetWithText(OutlinedButton, l10n.auth_button_switch_register),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.auth_title_register), findsOneWidget);
    expect(find.text(l10n.auth_label_password_again), findsOneWidget);

    await tester.enterText(
      find.byType(TextField).at(0),
      'new-user@example.com',
    );
    await tester.enterText(find.byType(TextField).at(1), 'secret123');
    await tester.enterText(find.byType(TextField).at(2), 'secret123');
    await tester.tap(
      find.widgetWithText(TextButton, l10n.auth_button_action_register),
    );
    await tester.pumpAndSettle();

    expect(harness.registerCalls, 1);
    expect(harness.registerEmail, 'new-user@example.com');
    expect(harness.registerPassword, 'secret123');
    expect(find.text(l10n.verification_title), findsOneWidget);
  });

  testWidgets('unverified login opens email verification page', (
    WidgetTester tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('cs'));
    final harness = _AuthFlowHarness()..loginEmailVerified = false;

    await _pumpAuthFlow(tester, harness);
    await tester.enterText(
      find.byType(TextField).at(0),
      'pending@example.com',
    );
    await tester.enterText(find.byType(TextField).at(1), 'secret123');
    await tester.tap(
      find.widgetWithText(TextButton, l10n.auth_button_action_login),
    );
    await tester.pumpAndSettle();

    expect(harness.loginCalls, 1);
    expect(harness.loggedInCalls, 0);
    expect(find.text(l10n.verification_title), findsOneWidget);
    expect(find.text(l10n.verification_button_check), findsOneWidget);
  });

  testWidgets('verification page delegates check, resend, and logout actions', (
    WidgetTester tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('cs'));
    final harness = _AuthFlowHarness();

    await _pumpAuthFlow(
      tester,
      harness,
      state: FlutterAuthFlowState.emailVerification,
    );

    expect(find.text(l10n.verification_title), findsOneWidget);

    await tester.tap(
      find.widgetWithText(TextButton, l10n.verification_button_check),
    );
    await tester.pumpAndSettle();

    expect(harness.checkVerificationCalls, 1);
    expect(harness.loggedInCalls, 1);

    await tester.tap(
      find.widgetWithText(OutlinedButton, l10n.verification_button_resend),
    );
    await tester.pumpAndSettle();

    expect(harness.resendVerificationCalls, 1);
    expect(find.text(l10n.success_email_verification_sent), findsOneWidget);

    await tester.tap(find.text(l10n.verification_button_logout));
    await tester.pumpAndSettle();

    expect(harness.logoutCalls, 1);
    expect(harness.loggedOutCalls, 1);
    expect(find.text(l10n.auth_title_login), findsOneWidget);
  });
}

Future<void> _pumpAuthFlow(
  WidgetTester tester,
  _AuthFlowHarness harness, {
  FlutterAuthFlowState state = FlutterAuthFlowState.login,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        locale: const Locale('cs'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: FlutterAuthFlow(harness.dependencies, state: state),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _AuthFlowHarness {
  bool? loginEmailVerified = true;
  bool? checkEmailVerified = true;
  int loginCalls = 0;
  int registerCalls = 0;
  int resetPasswordCalls = 0;
  int checkVerificationCalls = 0;
  int resendVerificationCalls = 0;
  int logoutCalls = 0;
  int loggedInCalls = 0;
  int loggedOutCalls = 0;
  int loginAboutCalls = 0;
  int privacyPolicyCalls = 0;
  String? loginEmail;
  String? loginPassword;
  String? registerEmail;
  String? registerPassword;
  String? resetPasswordEmail;

  late final FlutterAuthFlowDependencies dependencies =
      FlutterAuthFlowDependencies(
    activityIndicator: const SizedBox(
      key: ValueKey<String>('auth-loading-indicator'),
      width: 24,
      height: 24,
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
    loginAboutText: 'About auth',
    onLoginAboutTextPressed: () {
      loginAboutCalls++;
    },
    onPrivacyPolicyPressed: () {
      privacyPolicyCalls++;
    },
    onLoginPressed: ({
      required String email,
      required String password,
      required void Function({String? errorMessage, bool? isEmailVerified})
          onLoginDone,
    }) {
      loginCalls++;
      loginEmail = email;
      loginPassword = password;
      onLoginDone(isEmailVerified: loginEmailVerified);
    },
    onRegisterPressed: ({
      required String email,
      required String password,
      required void Function({String? errorMessage}) onRegisterDone,
    }) {
      registerCalls++;
      registerEmail = email;
      registerPassword = password;
      onRegisterDone();
    },
    onCheckVerificationPressed: ({
      required void Function({String? errorMessage, bool? isEmailVerified})
          onCheckDone,
    }) {
      checkVerificationCalls++;
      onCheckDone(isEmailVerified: checkEmailVerified);
    },
    onResendVerificationPressed: ({
      required void Function({String? errorMessage}) onResendDone,
    }) {
      resendVerificationCalls++;
      onResendDone();
    },
    onLogoutPressed: ({
      required void Function({String? errorMessage}) onLogoutDone,
    }) {
      logoutCalls++;
      onLogoutDone();
    },
    onResetPasswordPressed: ({
      required String email,
      required void Function({String? errorMessage}) onResetDone,
    }) {
      resetPasswordCalls++;
      resetPasswordEmail = email;
      onResetDone();
    },
    onLoggedIn: () {
      loggedInCalls++;
    },
    onLoggedOut: () {
      loggedOutCalls++;
    },
    colorPrimary: Colors.blue,
    colorOnPrimary: Colors.white,
    colorSecondary: Colors.white,
    colorOnSecondary: Colors.black,
    colorAbout: Colors.yellow,
    colorError: Colors.red,
    colorOnError: Colors.white,
    colorSuccess: Colors.green,
    colorOnSuccess: Colors.white,
  );
}
