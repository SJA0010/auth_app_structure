import 'package:auth_app_structure/scr/app_theme/color_scheme.dart';
import 'package:auth_app_structure/scr/app_theme/text_theme.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:auth_app_structure/scr/features/auths/controllers/facebook_auth_provider.dart';
import 'package:auth_app_structure/scr/features/auths/pages/otp_auth.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/pages/sign_up.dart';
import 'package:auth_app_structure/scr/features/home/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacebookAuthentication extends StatefulWidget {
  const FacebookAuthentication({super.key});

  @override
  State<FacebookAuthentication> createState() => _FacebookAuthenticationState();
}

class _FacebookAuthenticationState extends State<FacebookAuthentication> {
  @override
  Widget build(BuildContext context) {
    final facebookProvider = Provider.of<FacebookSignInProvider>(context);
    final user = facebookProvider.user;
    final errorMessage = facebookProvider.errorMessage;

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
          child: user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display Profile Picture
                    if (user.photoURL != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                        radius: 40,
                      ),
                    const SizedBox(height: 10),
                    // Display Name
                    Text(
                      user.displayName ?? 'User',
                      style: appTextTheme.displaySmall,
                    ),
                    const SizedBox(height: 20),
                    CustomTextButton(
                      backgroundColor: Colors.red[700],
                      onPressed: () {
                        facebookProvider.signOut();
                      },
                      text: "Sign Out",
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Facebook Sign In",
                      style: appTextTheme.displaySmall,
                    ),
                    const SizedBox(height: 20),
                    CustomTextButton(
                      backgroundColor: Colors.blue[700],
                      onPressed: () {
                        facebookProvider.signInWithFacebook().then((_) {
                          if (facebookProvider.user != null) {
                          } else if (errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        });
                      },
                      text: "Sign In",
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
