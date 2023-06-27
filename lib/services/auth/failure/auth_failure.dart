import 'failures.dart';

class AuthFailure implements AuthenticationFailures {
  @override
  String loginFailures(e) {
    if (e.code == AuthenticationFailures.wrong_password) {
      return AuthenticationFailures.wrong_password;
    } else if (e.code == AuthenticationFailures.user_not_found) {
      return AuthenticationFailures.user_not_found;
    } else if (e.code == AuthenticationFailures.invalid_email) {
      return AuthenticationFailures.invalid_email;
    } else if (e.code == AuthenticationFailures.user_disabled) {
      return 'Your account is disabled';
    } else {
      return AuthenticationFailures.something_wrong;
    }
  }

  @override
  String registrationFailures(e) {
    if (e.code == AuthenticationFailures.email_already_in_use) {
      return AuthenticationFailures.email_already_in_use;
    } else if (e.code == AuthenticationFailures.operation_not_allowed) {
      return AuthenticationFailures.operation_not_allowed;
    } else if (e.code == AuthenticationFailures.invalid_email) {
      return AuthenticationFailures.invalid_email;
    } else if (e.code == AuthenticationFailures.weak_password) {
      return 'Type atleast 6 charecter password';
    } else {
      return AuthenticationFailures.something_wrong;
    }
  }
}
