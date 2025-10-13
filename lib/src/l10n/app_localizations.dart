import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('cs')];

  /// No description provided for @auth_title_login.
  ///
  /// In cs, this message translates to:
  /// **'Přihlásit se'**
  String get auth_title_login;

  /// No description provided for @auth_title_register.
  ///
  /// In cs, this message translates to:
  /// **'Registrovat se'**
  String get auth_title_register;

  /// No description provided for @auth_label_email.
  ///
  /// In cs, this message translates to:
  /// **'E-mail'**
  String get auth_label_email;

  /// No description provided for @auth_hint_email.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte e-mail'**
  String get auth_hint_email;

  /// No description provided for @auth_label_password.
  ///
  /// In cs, this message translates to:
  /// **'Heslo'**
  String get auth_label_password;

  /// No description provided for @auth_hint_password.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte heslo'**
  String get auth_hint_password;

  /// No description provided for @auth_label_password_again.
  ///
  /// In cs, this message translates to:
  /// **'Heslo znovu'**
  String get auth_label_password_again;

  /// No description provided for @auth_hint_password_again.
  ///
  /// In cs, this message translates to:
  /// **'Opakujte heslo'**
  String get auth_hint_password_again;

  /// No description provided for @auth_button_action_login.
  ///
  /// In cs, this message translates to:
  /// **'Přihlásit'**
  String get auth_button_action_login;

  /// No description provided for @auth_button_action_register.
  ///
  /// In cs, this message translates to:
  /// **'Registrovat'**
  String get auth_button_action_register;

  /// No description provided for @auth_button_switch_register.
  ///
  /// In cs, this message translates to:
  /// **'Ještě nemám účet'**
  String get auth_button_switch_register;

  /// No description provided for @auth_button_switch_login.
  ///
  /// In cs, this message translates to:
  /// **'Již mám účet'**
  String get auth_button_switch_login;

  /// No description provided for @error_universal.
  ///
  /// In cs, this message translates to:
  /// **'Něco se nepovedlo'**
  String get error_universal;

  /// No description provided for @auth_help_password_title.
  ///
  /// In cs, this message translates to:
  /// **'Požadavky'**
  String get auth_help_password_title;

  /// No description provided for @auth_help_password_content.
  ///
  /// In cs, this message translates to:
  /// **'\n- alespoň 6 znaků.'**
  String get auth_help_password_content;

  /// No description provided for @auth_help_password_ok.
  ///
  /// In cs, this message translates to:
  /// **'OK'**
  String get auth_help_password_ok;

  /// No description provided for @auth_title_privacy_policy.
  ///
  /// In cs, this message translates to:
  /// **'* Registrací souhlasím se zásadami ochany osobních údajů.'**
  String get auth_title_privacy_policy;

  /// No description provided for @error_auth_email_in_use.
  ///
  /// In cs, this message translates to:
  /// **'Účet již existuje'**
  String get error_auth_email_in_use;

  /// No description provided for @error_auth_email_invalid.
  ///
  /// In cs, this message translates to:
  /// **'Nesprávný email'**
  String get error_auth_email_invalid;

  /// No description provided for @error_auth_pass_not_matching.
  ///
  /// In cs, this message translates to:
  /// **'Neshodná hesla'**
  String get error_auth_pass_not_matching;

  /// No description provided for @error_auth_user_not_found.
  ///
  /// In cs, this message translates to:
  /// **'Uživatel nenalezen'**
  String get error_auth_user_not_found;

  /// No description provided for @error_auth_weak_password.
  ///
  /// In cs, this message translates to:
  /// **'Slabé heslo'**
  String get error_auth_weak_password;

  /// No description provided for @error_auth_wrong_password.
  ///
  /// In cs, this message translates to:
  /// **'Nesprávné heslo'**
  String get error_auth_wrong_password;

  /// No description provided for @error_auth_operation_not_allowed.
  ///
  /// In cs, this message translates to:
  /// **'Operace nepodporována'**
  String get error_auth_operation_not_allowed;

  /// No description provided for @error_auth_user_disabled.
  ///
  /// In cs, this message translates to:
  /// **'Uživatel zablokován'**
  String get error_auth_user_disabled;

  /// No description provided for @error_auth_invalid_credential.
  ///
  /// In cs, this message translates to:
  /// **'Neplatné údaje'**
  String get error_auth_invalid_credential;

  /// No description provided for @error_email_not_verified.
  ///
  /// In cs, this message translates to:
  /// **'Email neověřen'**
  String get error_email_not_verified;

  /// No description provided for @error_user_logged_out.
  ///
  /// In cs, this message translates to:
  /// **'Jste odhlášeni'**
  String get error_user_logged_out;

  /// No description provided for @success_email_verification_sent.
  ///
  /// In cs, this message translates to:
  /// **'Odesláno na email'**
  String get success_email_verification_sent;

  /// No description provided for @verification_title.
  ///
  /// In cs, this message translates to:
  /// **'Potvrďte prosím email'**
  String get verification_title;

  /// No description provided for @verification_subtitle.
  ///
  /// In cs, this message translates to:
  /// **'Email s potvrzením naleznete ve své emailové schránce.'**
  String get verification_subtitle;

  /// No description provided for @verification_button_check.
  ///
  /// In cs, this message translates to:
  /// **'Zkontrolovat'**
  String get verification_button_check;

  /// No description provided for @verification_button_resend.
  ///
  /// In cs, this message translates to:
  /// **'Odeslat znovu'**
  String get verification_button_resend;

  /// No description provided for @verification_button_logout.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit se'**
  String get verification_button_logout;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['cs'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return AppLocalizationsCs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
