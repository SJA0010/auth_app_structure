import 'package:auth_app_structure/scr/app_theme/color_scheme.dart';
import 'package:auth_app_structure/scr/app_theme/text_theme.dart';
import 'package:auth_app_structure/scr/app_theme/theme_notifier.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_field.dart';
import 'package:auth_app_structure/scr/features/auths/pages/facebook_auth.dart';
import 'package:auth_app_structure/scr/features/auths/pages/google_auth.dart';
import 'package:auth_app_structure/scr/features/auths/pages/otp_auth.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/controllers/signup_provider.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseSignUp extends StatelessWidget {
  const FirebaseSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the SignUpProvider
    final signUpProvider = Provider.of<SignUpProvider>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool switchVal = themeNotifier.themeMode == ThemeMode.dark;
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
          child: Column(
            children: [
              Switch(
                inactiveTrackColor: Colors.white,
                onChanged: (bool value) {
                  themeNotifier.toggleTheme(value);
                },
                value: switchVal,
              ),
              Center(
                child: Text(
                  "Firebase Sign Up",
                  style: appTextTheme.displaySmall,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                hint: "Email",
                focusBorderColor: Colors.blue,
                controller: signUpProvider.emailController,
                validationType: ValidationType.email,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: signUpProvider.nameController,
                hint: "Name",
                focusBorderColor: Colors.blue,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: signUpProvider.phoneController,
                hint: "Phone",
                focusBorderColor: Colors.blue,
                validationType: ValidationType.phoneNumber,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                  controller: signUpProvider.passwordController,
                  hint: "password",
                  obscureText: signUpProvider.isPasswordVisible,
                  focusBorderColor: Colors.blue,
                  validationType: ValidationType.password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      signUpProvider.toggleVisibility();
                    },
                    icon: Icon(
                      signUpProvider.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )),
              SizedBox(height: 20),
              CustomTextButton(
                  onPressed: () {
                    signUpProvider.signUpUser(context);
                  },
                  text: signUpProvider.isLoading ? "Signing Up..." : "Sign Up"),
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
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  CustomTextButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirebaseSignIn(),
                        ),
                      );
                    },
                    text: "Log in",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
