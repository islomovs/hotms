import 'package:flutter/material.dart';

import '../constants/registration_constants.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  static const routeName = '/reset-password-screen';

  final _formKey = GlobalKey<FormState>();
  String? _password;
  String? _confirmPassword;

  void _submitData(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      Navigator.popUntil(ctx, ModalRoute.withName('/'));
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
                horizontal: 80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainTitle(
                      title: 'Reset your password',
                      subtitle: 'Enter a new password for your account'),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 390,
                      child: Column(
                        children: [
                          TextFormField(
                            obscureText: true,
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _password = value,
                            validator: validatePassword,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _confirmPassword = value,
                            validator: (value) => validateConfirmPassword(
                                _confirmPassword, _password),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                    title: 'Reset Password',
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
