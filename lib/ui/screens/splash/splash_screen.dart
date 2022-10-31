import 'package:cook_recipe/core/services/auth_service.dart';
import 'package:cook_recipe/ui/screens/auth/signin_screen.dart';
import 'package:cook_recipe/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigate();
  }

  _navigate() async {
    Future.delayed(const Duration(seconds: 1), () {
      if (FirebaseAuthService.currentUser == null) {
        Navigator.pushNamedAndRemoveUntil(context, SigninScreen.routeName, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
