import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
  // ignore: prefer_final_fields
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupwithemailandpass(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use ') {
        Fluttertoast.showToast(msg: 'The Email is already use');
      } else {
        Fluttertoast.showToast(msg: 'An Error:${e.code}');
      }
    }
    return null;
  }

  Future<User?> signinwithemailandpass(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use ') {
        Fluttertoast.showToast(msg: 'invalid-email or password');
      } else {
        Fluttertoast.showToast(msg: 'An Error:${e.code}');
      }
      return null;
    }
  }
}
