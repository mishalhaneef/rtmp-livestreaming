import 'server_failures.dart';

class ServerAuthFailure implements ServerAuthenticationFailures {
  @override
  String loginFailures(e) {
    if (e.code == ServerAuthenticationFailures.wrong_password) {
      return ServerAuthenticationFailures.wrong_password;
    } else if (e.code == ServerAuthenticationFailures.user_not_found) {
      return ServerAuthenticationFailures.user_not_found;
    } else if (e.code == ServerAuthenticationFailures.invalid_email) {
      return ServerAuthenticationFailures.invalid_email;
    } else if (e.code == ServerAuthenticationFailures.user_disabled) {
      return 'Your account is disabled';
    } else {
      return ServerAuthenticationFailures.something_wrong;
    }
  }

  @override
  String registrationFailures(e) {
    if (e.code == ServerAuthenticationFailures.email_already_in_use) {
      return ServerAuthenticationFailures.email_already_in_use;
    } else if (e.code == ServerAuthenticationFailures.operation_not_allowed) {
      return ServerAuthenticationFailures.operation_not_allowed;
    } else if (e.code == ServerAuthenticationFailures.invalid_email) {
      return ServerAuthenticationFailures.invalid_email;
    } else if (e.code == ServerAuthenticationFailures.weak_password) {
      return 'Type atleast 6 charecter password';
    } else {
      return ServerAuthenticationFailures.something_wrong;
    }
  }
}
