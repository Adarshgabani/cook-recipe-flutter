import 'package:cook_recipe/core/models/recipe_model.dart';
import 'package:flutter/material.dart';

class AllRecipeProvider extends ChangeNotifier {
  List<RecipeModel> _allRecipes = [];
  List<RecipeModel> get allRecipes => _allRecipes;

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  setCurrentPageIndex(int index) {
    _currentPageIndex = currentPageIndex;
    notifyListeners();
  }

  setAllRecipes(List<RecipeModel> recipes) {
    _allRecipes = recipes;
    notifyListeners();
  }

  addRecipe(RecipeModel recipe) {
    if (!_allRecipes.contains(recipe)) {
      _allRecipes.add(recipe);
      notifyListeners();
    }
  }
}
