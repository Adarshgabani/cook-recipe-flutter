import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_recipe/core/models/method_model.dart';
import 'package:cook_recipe/core/models/recipe_model.dart';
import 'package:cook_recipe/core/providers/all_recipe_provider.dart';
import 'package:cook_recipe/core/services/auth_service.dart';
import 'package:cook_recipe/core/services/firebase_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirestoreService {
  static Future<String?> createUser({required BuildContext context, required String emailAddress, required String password, required String username}) async {
    String response = await FirebaseAuthService.registerUser(context: context, emailAddress: emailAddress, password: password);
    if (response == "SUCCESS") {
      print("current user:: ${FirebaseAuthService.currentUser}");
      if (FirebaseAuthService.currentUser != null) {
        FirebaseAuth.instance.currentUser?.updateDisplayName(username.trim());

        await FirebaseFirestore.instance.collection("USERS").doc(FirebaseAuthService.currentUser!.uid).set({
          'id': FirebaseAuthService.currentUser!.uid,
          'username': username,
          'email': emailAddress,
        });
      }
      return null;
    } else {
      return response;
    }
  }

  static Future<String?> storeRecipe(BuildContext context, RecipeModel recipeModel) async {
    RecipeModel _recipeModel = recipeModel;
    if (recipeModel.imageUrl != null) {
      print("Started Uploading");

      var imageUrl = await FirebaseStorageService.storeImage(recipeModel.imageUrl!);
      _recipeModel = recipeModel.copyWith(imageUrl: imageUrl);
      print(imageUrl);
    }
    try {
      List<MethodModel> _methodModels = [];

      await Future.forEach(recipeModel.methods, (element) async {
        print("ELEMENT:::: ${element.imageUrl}");
        if (element.imageUrl != null) {
          var imageUrl = await FirebaseStorageService.storeImage(element.imageUrl!);
          _methodModels.add(MethodModel(method: element.method, imageUrl: imageUrl));
        } else {
          _methodModels.add(element);
        }
      });
      print("methjod:::: $_methodModels");
      _recipeModel = _recipeModel.copyWith(methods: _methodModels);

      await FirebaseFirestore.instance.collection("USERS").doc(FirebaseAuthService.currentUser!.uid).collection("RECIPES").doc().set(_recipeModel.toJson());
      Provider.of<AllRecipeProvider>(context, listen: false).addRecipe(_recipeModel);
      return null;
    } catch (e) {
      log("ERROR::: storeRecipe ${e}");
      return e.toString();
    }
  }

  static Future<List<RecipeModel>> getRecipe(BuildContext context) async {
    if (Provider.of<AllRecipeProvider>(context, listen: false).allRecipes.isNotEmpty) {
      return Provider.of<AllRecipeProvider>(context, listen: false).allRecipes;
    }
    try {
      var ref = FirebaseFirestore.instance.collection("USERS").doc(FirebaseAuthService.currentUser!.uid).collection("RECIPES").withConverter(
          fromFirestore: RecipeModel.fromFirestore,
          toFirestore: (x, y) {
            return {};
          });
      var x = await ref.get();
      List<RecipeModel> list = x.docs
          .map(
            (e) => e.data(),
          )
          .toList();
      Provider.of<AllRecipeProvider>(context, listen: false).setAllRecipes(list);
      return list;
    } catch (e) {
      log("ERROR::: storeRecipe ${e}");
      return [];
    }
  }
}
