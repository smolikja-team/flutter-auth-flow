import 'package:firebase_auth_flow/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
