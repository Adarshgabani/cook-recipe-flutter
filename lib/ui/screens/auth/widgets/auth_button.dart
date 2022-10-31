import 'package:flutter/material.dart';

class AuthButtonWidget extends StatefulWidget {
  const AuthButtonWidget({super.key, required this.title, this.onTap});

  final String title;
  final Future<void> Function()? onTap;

  @override
  State<AuthButtonWidget> createState() => _AuthButtonWidgetState();
}

class _AuthButtonWidgetState extends State<AuthButtonWidget> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isLoading
            ? const CircularProgressIndicator(
                strokeWidth: 3,
              )
            : TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await widget.onTap?.call();
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
      ),
    );
  }
}
