import 'package:auth_app_structure/scr/app_theme/theme.dart';
import 'package:auth_app_structure/scr/app_theme/theme_notifier.dart';
import 'package:auth_app_structure/scr/features/auths/controllers/facebook_auth_provider.dart';
import 'package:auth_app_structure/scr/features/auths/controllers/google_provider.dart';
import 'package:auth_app_structure/scr/features/auths/controllers/otp_provider.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/controllers/signin_provider.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/controllers/signup_provider.dart';
import 'package:auth_app_structure/scr/features/firebase_sign/pages/sign_up.dart';
import 'package:auth_app_structure/scr/features/home/controllers/greeting_provider.dart';
import 'package:auth_app_structure/scr/features/home/controllers/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ThemeNotifier themeNotifier = await ThemeNotifier.create();

  runApp(MyApp(themeNotifier: themeNotifier));
}

class MyApp extends StatelessWidget {
  final ThemeNotifier? themeNotifier;

  const MyApp({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>.value(
            value: themeNotifier ?? ThemeNotifier(ThemeMode.light),
          ),
          // ChangeNotifierProvider(
          //   create: (_) => UserProvider(),
          // ),
          ChangeNotifierProvider(create: (_) => SignUpProvider()),
          ChangeNotifierProvider(create: (_) => GreetingProvider()),
          ChangeNotifierProvider(create: (_) => SignInProvider()),
          ChangeNotifierProvider(create: (_) => AllUsersProvider()),
          ChangeNotifierProvider(create: (_) => OtpAuthProvider()),
          ChangeNotifierProvider(create: (_) => FacebookSignInProvider()),
          ChangeNotifierProvider<GoogleProvider>(
            create: (_) => GoogleProvider(),
          ),
        ],
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.instance.lightTheme,
              darkTheme: AppTheme.instance.darkTheme,
              themeMode: themeNotifier.themeMode,
              home: const FirebaseSignUp(),
            );
          },
        ),
      ),
    );
  }
}
