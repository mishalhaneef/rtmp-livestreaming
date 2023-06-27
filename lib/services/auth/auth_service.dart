
abstract class AuthenticationService {
  Future signinWithEmailAndPassword(String email, String password);
  Future registerWithEmailAndPassword(String email, String password);
  Future signOut();
}
