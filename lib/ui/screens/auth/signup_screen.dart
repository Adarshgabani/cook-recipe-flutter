import 'package:cook_recipe/ui/shared/widgets/custom_textfield_widget.dart';
import 'package:cook_recipe/utils/enums.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = '/signup';

  SignupScreen({super.key});

  final TextEditingController _username = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CustomTextFieldWidget(controller: _username, textFieldType: TextFieldType.username),
              const SizedBox(height: 24),
              CustomTextFieldWidget(controller: _emailController, textFieldType: TextFieldType.email),
              const SizedBox(height: 24),
              CustomTextFieldWidget(controller: _passwordController, textFieldType: TextFieldType.password),
              const SizedBox(height: 48),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a member? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
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
