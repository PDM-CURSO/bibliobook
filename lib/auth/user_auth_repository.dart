import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isAlreadyAuthenticated() {
    return _auth.currentUser != null;
  }

  Future<void> signOutGoogleUser() async {
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebaseUser() async {
    await _auth.signOut();
  }

  Future<void> signInAnonymous() async {
    await _auth.signInAnonymously();
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    // print(">> User name: ${googleUser.displayName}");
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    await _auth.signInWithCredential(credential);
  }
}
