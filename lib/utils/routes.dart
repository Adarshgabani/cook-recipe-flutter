import 'package:cook_recipe/ui/screens/auth/signin_screen.dart';
import 'package:cook_recipe/ui/screens/auth/signup_screen.dart';
import 'package:cook_recipe/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  SigninScreen.routeName: (_) => SigninScreen(),
  SignupScreen.routeName: (_) => SignupScreen(),

  // Wrapper.routeName: (context) => Wrapper(),
  // LoginScreen.routeName: (context) => LoginScreen(),
  // RegisterScreen.routeName: (context) => RegisterScreen(),
  // HomeScreen.routeName: (context) => HomeScreen(),
  // CategoriesScreen.routeName: (context) => CategoriesScreen(),
  // CategoryScreen.routeName: (context) => CategoryScreen(),
  // ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
  // CartScreen.routeName: (context) => CartScreen(),
  // OrdersScreen.routeName: (context) => OrdersScreen(),
  // YourOrderScreen.routeName: (context) => YourOrderScreen(),
};
