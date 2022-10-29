import 'package:cook_recipe/utils/enums.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({super.key, required this.controller, required this.textFieldType, this.isDoneAction = false});

  final TextEditingController controller;
  final TextFieldType textFieldType;
  final bool isDoneAction;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.textFieldType) {
      case TextFieldType.email:
        return TextFormField(
          textInputAction: widget.isDoneAction ? TextInputAction.done : TextInputAction.next,
          controller: widget.controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
          ),
        );
      case TextFieldType.username:
        return TextFormField(
          textInputAction: widget.isDoneAction ? TextInputAction.done : TextInputAction.next,
          controller: widget.controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Username"),
          ),
        );
      case TextFieldType.password:
        return TextFormField(
          controller: widget.controller,
          obscureText: isHidePassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Password"),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isHidePassword = !isHidePassword;
                });
              },
              icon: Icon(
                isHidePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
        );
      default:
        return TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
          ),
        );
    }
  }
}
