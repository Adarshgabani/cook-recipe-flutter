import 'package:cook_recipe/utils/enums.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({super.key, required this.controller, required this.textFieldType, this.isDoneAction = false, this.placeholder});

  final TextEditingController controller;
  final TextFieldType textFieldType;
  final bool isDoneAction;
  final String? placeholder;

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
          keyboardType: TextInputType.emailAddress,
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
          keyboardType: TextInputType.visiblePassword,
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
      case TextFieldType.input:
        return TextFormField(
          controller: widget.controller,
          textInputAction: widget.isDoneAction ? TextInputAction.done : TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.orangeAccent.withOpacity(0.2),
            filled: true,
            label: Text(widget.placeholder ?? "hint"),
          ),
        );
      case TextFieldType.number:
        return TextFormField(
          controller: widget.controller,
          textInputAction: widget.isDoneAction ? TextInputAction.done : TextInputAction.next,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            fillColor: Colors.orangeAccent.withOpacity(0.2),
            filled: true,
            // label: Text(widget.placeholder ?? "hint"),
          ),
        );
      default:
        return TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
          ),
        );
    }
  }
}
