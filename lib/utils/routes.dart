import 'package:cook_recipe/ui/screens/add_recipe/add_recipe_screen.dart';
import 'package:cook_recipe/ui/screens/auth/signin_screen.dart';
import 'package:cook_recipe/ui/screens/auth/signup_screen.dart';
import 'package:cook_recipe/ui/screens/home/home_screen.dart';
import 'package:cook_recipe/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  SigninScreen.routeName: (_) => SigninScreen(),
  SignupScreen.routeName: (_) => SignupScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
  AddRecipeScreen.routeName: (_) => AddRecipeScreen(),
};
