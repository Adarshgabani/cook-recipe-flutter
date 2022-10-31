import 'package:cook_recipe/core/models/method_model.dart';
import 'package:cook_recipe/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipeProvider extends ChangeNotifier {
  AddRecipeStep _currentStep = AddRecipeStep.recipe;
  AddRecipeStep get currentStep => _currentStep;

  String? _recipeImagePath;
  String? get recipeImagePath => _recipeImagePath;

  int _serves = 1;
  int get serves => _serves;

  List<String> _ingredients = [];
  List<String> get ingredients => _ingredients;

  List<MethodModel> _methods = [];
  List<MethodModel> get methods => _methods;

  setservePersonCount(int? count) {
    if (count != null) {
      _serves = count;
      notifyListeners();
    }
  }

  setRecipeImage() async {
    var x = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (x != null) {
      print(x.path);
      _recipeImagePath = x.path;
      notifyListeners();
    }
  }

  changeCurrentStep(AddRecipeStep step) {
    _currentStep = step;
    notifyListeners();
  }

  addIngredient(String ingredient) {
    if (!_ingredients.contains(ingredient)) {
      _ingredients.add(ingredient);
    }
    notifyListeners();
  }

  removeIngredient(String ingredient) {
    _ingredients.remove(ingredient);

    notifyListeners();
  }

  reorderIngredients(int oldindex, int newindex) {
    if (newindex > oldindex) {
      newindex -= 1;
    }
    final items = ingredients.removeAt(oldindex);
    ingredients.insert(newindex, items);
    notifyListeners();
  }

  addMethod(MethodModel method) {
    if (!_methods.contains(method)) {
      _methods.add(method);
    }
    notifyListeners();
  }

  removeMethod(MethodModel method) {
    _methods.remove(method);

    notifyListeners();
  }

  reorderMethod(int oldindex, int newindex) {
    if (newindex > oldindex) {
      newindex -= 1;
    }
    final items = methods.removeAt(oldindex);
    methods.insert(newindex, items);
    notifyListeners();
  }

  reset() {
    _currentStep = AddRecipeStep.recipe;
    _ingredients = [];
    _methods = [];
    _recipeImagePath = null;
    _serves = 1;
    notifyListeners();
  }
}
