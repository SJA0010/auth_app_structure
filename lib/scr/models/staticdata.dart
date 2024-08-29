import 'dart:convert';

import 'package:auth_app_structure/scr/features/firebase_sign/pages/sign_in.dart';
import 'package:auth_app_structure/scr/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Staticdata {
  //---------------------------for current user-----------------------------------
  static UserModel? model;

//-----------------------------for log out--------------------------
  static Future<void> signOut(BuildContext context) async {
    // Clear the in-memory user model
    Staticdata.model = null;

    // Obtain the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Remove only the 'currentUser' key
    prefs.setString('currentUser', json.encode(null));

    // Navigate back to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const FirebaseSignIn(),
      ),
      (Route<dynamic> route) => false, // This will remove all previous routes
    );
  }
}
