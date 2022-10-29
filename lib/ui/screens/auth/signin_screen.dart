import 'package:cook_recipe/ui/screens/auth/signup_screen.dart';
import 'package:cook_recipe/ui/shared/widgets/custom_textfield_widget.dart';
import 'package:cook_recipe/utils/enums.dart';
import 'package:flutter/material.dart';

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
              TextButton(
                onPressed: () {},
                child: const Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 18),
                ),
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
