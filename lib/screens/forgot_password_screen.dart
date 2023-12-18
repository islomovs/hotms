import 'package:flutter/material.dart';

import './verification_code_screen.dart';
import '../constants/registration_constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  static const routeName = '/forgot-password-screen';

  final _formKey = GlobalKey<FormState>();

  void _submitData(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(ctx).pushNamed(VerificationCodeScreen.routeName);
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
                horizontal: 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainTitle(
                      title: 'Forgot Password?',
                      subtitle:
                          'Enter you account email address and receive verification code '),
                  const SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 390,
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
                  const SizedBox(height: 40),
                  MainButton(
                    title: 'Get Link',
                    onTapFunc: () => _submitData(context),
                  ),
                  const SizedBox(height: 20),
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
