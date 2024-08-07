import 'package:firebase_auth_flow/email_verification_page/providers/email_verification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailVerificationProvider =
    StateNotifierProvider<EmailverificationNotifier, EmailVerificationState>(
  (ref) => EmailverificationNotifier(),
);

class EmailverificationNotifier extends StateNotifier<EmailVerificationState> {
  EmailverificationNotifier() : super(EmailVerificationState());
}
