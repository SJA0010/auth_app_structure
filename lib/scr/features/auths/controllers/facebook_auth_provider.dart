import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _errorMessage;
  String? _userName;
  String? _userProfilePicture;

  User? get user => _user;
  String? get errorMessage => _errorMessage;
  String? get userName => _userName;
  String? get userProfilePicture => _userProfilePicture;

  FacebookSignInProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user != null) {
      _user = user;

      // Fetch additional user details from Facebook
      final userData = await FacebookAuth.instance.getUserData();
      _userName = userData['name'];
      _userProfilePicture = userData['picture']['data']['url'];
    } else {
      _user = null;
      _userName = null;
      _userProfilePicture = null;
    }
    notifyListeners();
  }

  Future<void> signInWithFacebook() async {
    try {
      // Reset the error message before attempting sign-in
      _errorMessage = null;

      // Trigger the Facebook sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Get the Facebook access token
        final AccessToken? facebookAccessToken = result.accessToken;

        if (facebookAccessToken != null) {
          // Create a credential for Firebase
          final OAuthCredential credential =
              FacebookAuthProvider.credential(facebookAccessToken.tokenString);

          // Sign in with the credential
          await _auth.signInWithCredential(credential);
        } else {
          _errorMessage = 'Failed to get Facebook access token.';
        }
      } else if (result.status == LoginStatus.cancelled) {
        // Handle cancellation
        _errorMessage = 'Facebook login cancelled by user.';
      } else if (result.status == LoginStatus.failed) {
        // Handle error
        _errorMessage = 'Facebook login failed: ${result.message}';
      }
    } catch (e) {
      // Capture and store any other errors
      _errorMessage = 'Error during Facebook sign-in: $e';
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    _userName = null;
    _userProfilePicture = null;
    notifyListeners();
  }
}
