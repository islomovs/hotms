import 'package:flutter/material.dart';

import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import './screens/forgot_password_screen.dart';
import './screens/reset_password_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donor Aid Login',
      routes: {
        '/': (ctx) => const LoginScreen(),
        RegistrationScreen.routeName: (ctx) => const RegistrationScreen(),
        ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
        ResetPasswordScreen.routeName: (ctx) => ResetPasswordScreen(),
      },
    );
  }
}

// ignore: must_be_immutable

