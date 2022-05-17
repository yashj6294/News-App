import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:logger/logger.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Logger log = Logger();
  static User? user = _auth.currentUser;
  static Future<User?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user != null) {
        credentials.user!.updateDisplayName(name);
      }
      return credentials.user;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      var credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credentials.user;
    } catch (e) {
      return null;
    }
  }

  static Future<void> signOut() async{
    await _auth.signOut();
  }
}
