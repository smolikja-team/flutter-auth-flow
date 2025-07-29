import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/src/l10n/app_localizations.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
