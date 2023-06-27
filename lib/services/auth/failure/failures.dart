// ignore_for_file: constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationFailures {
  String loginFailures(FirebaseException e);
  String registrationFailures(FirebaseException e);

  static const user_not_found = 'user-not-found';
  static const invalid_email = 'invalid-email';
  static const user_disabled = 'user-disabled';
  static const wrong_password = 'wrong-password';

  static const something_wrong = 'something went wrong';

  static const email_already_in_use = 'email-already-in-use';
  static const operation_not_allowed = 'operation-not-allowed';
  static const weak_password = 'weak-password';
}
