import 'package:auth_app_structure/scr/app_theme/color_scheme.dart';
import 'package:auth_app_structure/scr/app_theme/text_theme.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_field.dart';
import 'package:auth_app_structure/scr/features/auths/pages/facebook_auth.dart';
import 'package:auth_app_structure/scr/features/auths/pages/google_auth.dart';
import 'package:auth_app_structure/scr/features/auths/pages/otp_auth.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/controllers/signin_provider.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseSignIn extends StatelessWidget {
  const FirebaseSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the SignInProvider
    final signInProvider = Provider.of<SignInProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Firebase Authentications",
          style: appTextTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    "Firebase Sign In",
                    style: appTextTheme.displaySmall,
                  ),
                ),
                SizedBox(height: 50),
                CustomTextFormField(
                  controller: signInProvider.emailController,
                  hint: "Email",
                  focusBorderColor: Colors.blue,
                  validationType: ValidationType.email,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                    controller: signInProvider.passwordController,
                    hint: "Password",
                    focusBorderColor: Colors.blue,
                    validationType: ValidationType.password,
                    suffixIcon: IconButton(
                      onPressed: () {
                        signInProvider.toggleVisibility();
                      },
                      icon: Icon(
                        signInProvider.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    )),
                SizedBox(height: 30),
                CustomTextButton(
                    onPressed: () {
                      signInProvider.signInUser(context);
                    },
                    text:
                        signInProvider.isLoading ? "Signing In..." : "Sign In"),
                SizedBox(height: 50),
                Text(
                  "------------or SignIn with------------",
                  style: appTextTheme.labelLarge,
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: [
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpAuth(),
                          ),
                        );
                      },
                      text: "Phone",
                      backgroundColor: appDarkColorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FacebookAuthentication(),
                          ),
                        );
                      },
                      text: "Facebook",
                      backgroundColor: Colors.blue[800],
                    ),
                    const SizedBox(width: 10),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoogleAuth(),
                          ),
                        );
                      },
                      text: "Google",
                      backgroundColor: Colors.red[800],
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    CustomTextButton(
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FirebaseSignUp(),
                          ),
                        );
                      },
                      text: "Create Now",
                    )
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
