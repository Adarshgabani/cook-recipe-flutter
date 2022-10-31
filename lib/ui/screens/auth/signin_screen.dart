// ignore_for_file: use_build_context_synchronously

import 'package:cook_recipe/core/services/auth_service.dart';
import 'package:cook_recipe/core/services/firestore_service.dart';
import 'package:cook_recipe/ui/screens/auth/signup_screen.dart';
import 'package:cook_recipe/ui/screens/auth/widgets/auth_button.dart';
import 'package:cook_recipe/ui/screens/home/home_screen.dart';
import 'package:cook_recipe/ui/shared/widgets/custom_textfield_widget.dart';
import 'package:cook_recipe/utils/enums.dart';
import 'package:cook_recipe/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cook_recipe/utils/extensions.dart';

class SigninScreen extends StatelessWidget {
  static String routeName = '/signin';

  SigninScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          // title: Text("Sign in"),
          ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CustomTextFieldWidget(controller: _emailController, textFieldType: TextFieldType.email),
              const SizedBox(height: 24),
              CustomTextFieldWidget(controller: _passwordController, textFieldType: TextFieldType.password),
              const SizedBox(height: 48),
              AuthButtonWidget(
                title: "SIGN IN",
                onTap: () async {
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    showErrorMessage(context, errorMessage: "Please enter email,password and username");
                  } else if (!_emailController.text.isValidEmail()) {
                    showErrorMessage(context, errorMessage: "Please enter valid email");
                  } else if (!_passwordController.text.isValidPassword()) {
                    showErrorMessage(context, errorMessage: "Password should containe Uppercase,lowecase,number,special character and Must be at least 8 characters in length");
                  } else {
                    String? response = await FirebaseAuthService.signinWithEmail(context, emailAddress: _emailController.text, password: _passwordController.text);

                    if (response == null) {
//Navigate to home
                      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                    } else {
                      showErrorMessage(context, errorMessage: response);
                    }
                  }
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
