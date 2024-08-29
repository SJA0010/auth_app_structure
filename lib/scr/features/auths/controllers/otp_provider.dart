import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController numberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? _verificationId;
  bool _isLoading = false;

  // Getters
  bool get isLoading => _isLoading;

  // Function to send OTP
  Future<void> registerUser(BuildContext context) async {
    _setLoading(true);

    try {
      String mobile = "+${numberController.text.trim()}";
      await _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60), // Adjusted timeout
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          // Automatic verification and sign-in
          try {
            await _auth.signInWithCredential(phoneAuthCredential);
            _showSnackBar(
                context, "User verified and signed in automatically.");
            // Navigate to the next screen if needed
          } catch (e) {
            _showSnackBar(context,
                "Error during automatic verification: ${e.toString()}");
          }
        },
        verificationFailed: (FirebaseAuthException error) {
          // Handle errors during verification
          if (error.code == 'invalid-phone-number') {
            _showSnackBar(context, "The phone number entered is invalid.");
          } else {
            _showSnackBar(context, "Verification failed: ${error.message}");
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          // Store the verification ID for use in verifying the OTP
          _verificationId = verificationId;
          _showSnackBar(context, "Code sent to $mobile");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle auto-retrieval timeout
          _verificationId = verificationId;
          _showSnackBar(context,
              "Auto retrieval timeout. Please enter the OTP manually.");
        },
      );
    } catch (e) {
      _showSnackBar(context, "Error: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp(BuildContext context) async {
    if (_verificationId != null && otpController.text.trim().isNotEmpty) {
      String smsCode = otpController.text.trim();

      try {
        var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: smsCode,
        );

        await _auth.signInWithCredential(credential);
        _showSnackBar(context, "User verified successfully.");
        // Navigate to another screen here if needed
      } catch (e) {
        _showSnackBar(context, "Invalid verification code. Please try again.");
      }
    } else {
      _showSnackBar(context, "Please request the OTP again.");
    }
  }

  // Function to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Function to show a snackbar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Clean up controllers
  @override
  void dispose() {
    numberController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
