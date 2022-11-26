import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser = _auth.currentUser;

  Stream<User?> get user {
    return _auth.userChanges().asBroadcastStream();
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result;
    } catch (e) {}
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
