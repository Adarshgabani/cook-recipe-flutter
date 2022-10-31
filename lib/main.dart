import 'package:cook_recipe/core/providers/add_recipe_provider.dart';
import 'package:cook_recipe/core/providers/all_recipe_provider.dart';
import 'package:cook_recipe/core/providers/loader_provider.dart';
import 'package:cook_recipe/ui/screens/splash/splash_screen.dart';
import 'package:cook_recipe/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddRecipeProvider()),
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
        ChangeNotifierProvider(create: (_) => AllRecipeProvider()),
      ],
      child: MaterialApp(
        title: 'Cook Recipe',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.orange,
        ),
        routes: routes,
        initialRoute: SplashScreen.routeName,
        // home: HomeScreen(),
      ),
    );
  }
}
