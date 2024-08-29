import 'package:auth_app_structure/scr/app_theme/color_scheme.dart';
import 'package:auth_app_structure/scr/app_theme/text_theme.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:auth_app_structure/scr/features/auths/controllers/google_provider.dart';
import 'package:auth_app_structure/scr/features/auths/pages/otp_auth.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuth extends StatefulWidget {
  const GoogleAuth({super.key});

  @override
  State<GoogleAuth> createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Google Sign In",
                  style: appTextTheme.displaySmall,
                ),
              ),
              Consumer<GoogleProvider>(
                builder: (context, googleProvider, child) {
                  if (googleProvider.user != null) {
                    // User is logged in, display profile info
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(googleProvider.user!.photoURL ?? ''),
                        ),
                        SizedBox(height: 16),
                        Text(
                          googleProvider.user!.displayName ?? '',
                          style: appTextTheme.titleMedium,
                        ),
                        Text(
                          googleProvider.user!.email ?? '',
                          style: appTextTheme.titleSmall,
                        ),
                        SizedBox(height: 20),
                        CustomTextButton(
                          backgroundColor: Colors.red[600],
                          onPressed: () async {
                            googleProvider.signOut();
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                          },
                          text: "Sign Out",
                        ),
                      ],
                    );
                  } else if (googleProvider.errorMessage != null) {
                    // Error occurred during sign-in
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${googleProvider.errorMessage}'),
                        SizedBox(height: 16),
                        CustomTextButton(
                          onPressed: () {
                            googleProvider.signInWithGoogle();
                          },
                          text: 'Sign In with Google',
                          backgroundColor: Colors.red[600],
                        ),
                      ],
                    );
                  } else {
                    // No user is signed in, show sign-in button
                    return CustomTextButton(
                      onPressed: () {
                        googleProvider.signInWithGoogle();
                      },
                      backgroundColor: Colors.red[600],
                      text: 'Sign In with Google',
                    );
                  }
                },
              ),
              SizedBox(height: 150),
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
                          builder: (context) => FirebaseSignUp(),
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
    );
  }
}
