import 'package:flutter/material.dart';

import '../constants/registration_constants.dart';
import './reset_password_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  static const routeName = '/forgot-password-screen';

  final _formKey = GlobalKey<FormState>();

  void _submitData(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(ctx).pushNamed(ResetPasswordScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 118,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainTitle(
                      title: 'Forgot Password?',
                      subtitle:
                          'Enter your account email address and reset link will drop out'),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 400,
                      child: TextFormField(
                        style: originalTextStyle,
                        cursorColor: const Color(0xFF2B2B2B),
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          labelStyle: labelTextStyle,
                          enabledBorder: enabledBorderParams,
                          focusedBorder: focusedBorderParams,
                          errorBorder: errorBorderParams,
                          focusedErrorBorder: focusedErrorBorderParams,
                        ),
                        validator: validateEmail,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                    title: 'Get Link',
                    onTapFunc: () => _submitData(context),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const MainImage(),
        ],
      ),
    );
  }
}
