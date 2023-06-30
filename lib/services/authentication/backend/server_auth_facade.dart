import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/services/authentication/firebase/auth_service.dart';
import 'package:livestream/services/authentication/firebase/failure/auth_failure.dart';

class ServerAuthFacade implements AuthenticationService {
  final failure = AuthFailure();

  @override
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      final error = failure.registrationFailures(e);
      Fluttertoast.showToast(msg: error);
      return null;
    }
  }

  @override
  Future<UserCredential?> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseException catch (e) {
      final error = failure.loginFailures(e);
      Fluttertoast.showToast(msg: error);
      return null;
    }
  }

  @override
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
