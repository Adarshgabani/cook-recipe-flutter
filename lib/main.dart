import 'package:cook_recipe/ui/screens/home/home_screen.dart';
import 'package:cook_recipe/ui/screens/splash/splash_screen.dart';
import 'package:cook_recipe/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.orange,
      ),
      routes: routes,
      initialRoute: SplashScreen.routeName,
      // home: HomeScreen(),
    );
  }
}
