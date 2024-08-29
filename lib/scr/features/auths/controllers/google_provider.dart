import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? _user;
  String? _errorMessage;

  User? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        _user = userCredential.user;
        notifyListeners(); // Notify listeners about the change
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          _errorMessage = 'Account exists with a different credential';
        } else if (e.code == 'invalid-credential') {
          _errorMessage = 'Invalid credential';
        } else {
          _errorMessage = e.message;
        }
        notifyListeners(); // Notify listeners about the error
      } catch (e) {
        _errorMessage = 'An unknown error occurred';
        notifyListeners(); // Notify listeners about the error
      }
    } else {
      _errorMessage = 'Google Sign-In was cancelled';
      notifyListeners(); // Notify listeners about the cancellation
    }
  }

  void signOut() async {
    await auth.signOut();
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _user = null;
    notifyListeners(); // Notify listeners about the sign-out
  }
}
