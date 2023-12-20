import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/constants/constants.dart';

import '../constants/registration_constants.dart';
import './reset_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  VerificationCodeScreen({super.key});

  static const routeName = '/verification-code-screen';

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  void _submitData(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(ResetPasswordScreen.routeName);
  }

  final int codeLength = 4;
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void nextField(String value, int index) {
    if (value.length == 1 && index < codeLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainTitle(
                    title: 'Enter your code',
                    subtitle: 'We sent a code to your email, please enter',
                  ),
                  const SizedBox(height: 60),
                  Container(
                    width: 390,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(codeLength, (index) {
                        return Container(
                          width: 60,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: TextField(
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Inter',
                                color: blackCol,
                              ),
                              cursorColor: blackCol,
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              onChanged: (value) => nextField(value, index),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        );
                      }),
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
