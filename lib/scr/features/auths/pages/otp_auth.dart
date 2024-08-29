import 'package:auth_app_structure/scr/app_theme/text_theme.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_field.dart';
import 'package:auth_app_structure/scr/features/auths/controllers/otp_provider.dart';
import 'package:auth_app_structure/scr/features/auths/pages/google_auth.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpAuth extends StatelessWidget {
  const OtpAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final otpAuthProvider = Provider.of<OtpAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Firebase Authentications",
          style: appTextTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  "OTP Sign In",
                  style: appTextTheme.displaySmall,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  validationType: ValidationType.number,
                  labelText: "Phone",
                  keyboardType: TextInputType.number,
                  controller: otpAuthProvider.numberController,
                  focusBorderColor: Colors.blue,
                ),
                const SizedBox(height: 20),
                CustomTextButton(
                  onPressed: otpAuthProvider.isLoading
                      ? () {}
                      : () {
                          otpAuthProvider.registerUser(context);
                        },
                  text:
                      otpAuthProvider.isLoading ? "Sending OTP..." : "Send OTP",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  labelText: "Otp",
                  focusBorderColor: Colors.blue,
                  controller: otpAuthProvider.otpController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                CustomTextButton(
                  onPressed: otpAuthProvider.isLoading
                      ? () {}
                      : () {
                          otpAuthProvider.verifyOtp(context);
                        },
                  text: "Verify",
                ),
                const SizedBox(height: 100),
                Text(
                  "------------or SignIn with------------",
                  style: appTextTheme.labelLarge,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: [
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GoogleAuth(),
                          ),
                        );
                      },
                      text: "Google",
                      backgroundColor: Colors.red[700],
                    ),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FirebaseSignUp(),
                          ),
                        );
                      },
                      text: "Firebase Sign-up",
                      backgroundColor: Colors.green[800],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
