import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth_app_structure/scr/features/home/pages/home_screen.dart';
import 'package:auth_app_structure/scr/models/staticdata.dart';
import 'package:auth_app_structure/scr/models/user_model.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Editing Controllers for form inputs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // A flag to indicate if a sign-in process is ongoing
  bool _isLoading = false;

  // Getter for isLoading flag
  bool get isLoading => _isLoading;
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void toggleVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Function to sign in a user
  Future<void> signInUser(BuildContext context) async {
    _setLoading(true);

    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        _showSnackBar(context, "Please fill all fields");
        _setLoading(false);
        return;
      }

      QuerySnapshot query = await _firestore
          .collection("AllUsers")
          .where("email", isEqualTo: emailController.text)
          .where("password", isEqualTo: passwordController.text)
          .get();

      if (query.docs.isEmpty) {
        _showSnackBar(context, "Email or password is incorrect");
      } else {
        UserModel model =
            UserModel.fromMap(query.docs[0].data() as Map<String, dynamic>);
        Staticdata.model = model;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (e) {
      _showSnackBar(context, 'Error: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Function to set the loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Function to show a snackbar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
