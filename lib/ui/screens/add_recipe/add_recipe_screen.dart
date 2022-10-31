import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cook_recipe/core/models/method_model.dart';
import 'package:cook_recipe/core/models/recipe_model.dart';
import 'package:cook_recipe/core/providers/add_recipe_provider.dart';
import 'package:cook_recipe/core/providers/loader_provider.dart';
import 'package:cook_recipe/core/services/firestore_service.dart';
import 'package:cook_recipe/ui/shared/widgets/custom_textfield_widget.dart';
import 'package:cook_recipe/ui/shared/widgets/icon_button.dart';
import 'package:cook_recipe/utils/enums.dart';
import 'package:cook_recipe/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AddRecipeScreen extends StatelessWidget {
  static String routeName = '/addRecipe';

  AddRecipeScreen({super.key});
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String? recipeImagePath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: SafeArea(
              child: Consumer<AddRecipeProvider>(builder: (context, AddRecipeProvider addRecipeProvider, _) {
                var recipeWidget = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                            child: addRecipeProvider.recipeImagePath == null
                                ? InkWell(
                                    onTap: () async {
                                      addRecipeProvider.setRecipeImage();
                                    },
                                    borderRadius: BorderRadius.circular(24),
                                    child: Container(
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.orangeAccent.withOpacity(0.2),
                                      ),
                                      child: const Icon(
                                        Icons.add_a_photo,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.file(
                                        File(addRecipeProvider.recipeImagePath!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CustomTextFieldWidget(
                      placeholder: "Recipe name",
                      controller: _nameController,
                      textFieldType: TextFieldType.input,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text(
                          "Serves",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                        ),
                        const Spacer(),
                        DropdownButton(value: addRecipeProvider.serves, items: List.generate(10, (index) => DropdownMenuItem(value: index + 1, child: Text("${index + 1} Persons"))), onChanged: addRecipeProvider.setservePersonCount),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Time (in minutes)",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: CustomTextFieldWidget(
                            placeholder: "eg, 120",
                            controller: _timeController,
                            textFieldType: TextFieldType.number,
                          ),
                        ),
                      ],
                    )
                  ],
                );
                var ingredientWidget = Column(
                  children: [
                    const SizedBox(height: 24),
                    SizedBox(
                      height: addRecipeProvider.ingredients.length * 56,
                      child: ReorderableListView(
                          physics: const NeverScrollableScrollPhysics(),
                          onReorder: addRecipeProvider.reorderIngredients,
                          children: addRecipeProvider.ingredients
                              .map(
                                (e) => SizedBox(
                                  height: 56,
                                  key: Key(e),
                                  child: ListTile(
                                    leading: const Icon(Icons.reorder),
                                    title: Text(e),
                                    trailing: IconButton(
                                        onPressed: () {
                                          addRecipeProvider.removeIngredient(e);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    // ...addRecipeProvider.ingredients.map(
                    //   (e) => ListTile(
                    //     leading: Icon(Icons.reorder),
                    //     title: Text(e),
                    //     trailing: IconButton(
                    //         onPressed: () {
                    //           addRecipeProvider.removeIngredient(e);
                    //         },
                    //         icon: Icon(Icons.delete)),
                    //   ),
                    // ),
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        TextEditingController _ingredientController = TextEditingController();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Add Ingredient"),
                              content: CustomTextFieldWidget(
                                controller: _ingredientController,
                                textFieldType: TextFieldType.input,
                                placeholder: '',
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      print("111 ${_ingredientController.text}");
                                      if (_ingredientController.text.trim().isNotEmpty) {
                                        try {
                                          addRecipeProvider.addIngredient(_ingredientController.text);
                                        } catch (e) {
                                          log(e.toString());
                                        }
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("Save"))
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            const Text(
                              "Add ingredient",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                    // ReorderableListView(physics: NeverScrollableScrollPhysics(), children: [], onReorder: (a, b) {})
                  ],
                );
                var methods = Column(
                  children: [
                    const SizedBox(height: 24),
                    SizedBox(
                      height: addRecipeProvider.methods.length * 62,
                      child: ReorderableListView(
                          physics: const NeverScrollableScrollPhysics(),
                          onReorder: addRecipeProvider.reorderMethod,
                          children: addRecipeProvider.methods
                              .map(
                                (e) => Container(
                                  height: 60,
                                  key: Key(e.hashCode.toString()),
                                  child: Container(
                                    height: 52,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.reorder),
                                        const SizedBox(width: 12),
                                        if (e.imageUrl != null) Container(height: 56, width: 56, margin: const EdgeInsets.only(right: 12), child: Image.file(File(e.imageUrl!))),
                                        Expanded(
                                          child: Text(
                                            e.method,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        IconButton(
                                            onPressed: () {
                                              addRecipeProvider.removeMethod(e);
                                            },
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                    ),

                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController _controller = TextEditingController();
                            String? imagePath;
                            return StatefulBuilder(builder: (context, setState) {
                              return AlertDialog(
                                title: const Text("Add Method"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 56,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.orangeAccent.withOpacity(0.2),
                                      ),
                                      child: IconButton(
                                          onPressed: () async {
                                            XFile? x = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            setState(() {
                                              imagePath = x?.path;
                                            });
                                          },
                                          icon: imagePath == null ? const Icon(Icons.add_a_photo) : Image.file(File(imagePath!))),
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _controller,
                                      textInputAction: TextInputAction.newline,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText: "add method",
                                        fillColor: Colors.orangeAccent.withOpacity(0.2),
                                        filled: true,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        print("111 ${_controller.text}");
                                        if (_controller.text.trim().isNotEmpty) {
                                          try {
                                            addRecipeProvider.addMethod(MethodModel(method: _controller.text, imageUrl: imagePath));
                                          } catch (e) {
                                            log(e.toString());
                                          }
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text("Save"))
                                ],
                              );
                            });
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            const Text(
                              "Add method",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                    // ReorderableListView(physics: NeverScrollableScrollPhysics(), children: [], onReorder: (a, b) {})
                  ],
                );
                return GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Column(
                    children: [
                      Expanded(
                          child: Scaffold(
                        backgroundColor: Colors.white,
                        floatingActionButton: addRecipeProvider.currentStep == AddRecipeStep.method
                            ? FloatingActionButton(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                onPressed: () async {
                                  Provider.of<LoaderProvider>(context, listen: false).showLoader();
                                  await FirestoreService.storeRecipe(
                                      context,
                                      RecipeModel(
                                        recipeName: _nameController.text,
                                        imageUrl: addRecipeProvider.recipeImagePath,
                                        time: int.tryParse(_timeController.text.trim()),
                                        servesNumber: addRecipeProvider.serves,
                                        ingredients: addRecipeProvider.ingredients,
                                        methods: addRecipeProvider.methods,
                                      ));
                                  Provider.of<LoaderProvider>(context, listen: false).hideLoader();

                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.done),
                              )
                            : null,
                        body: Center(
                          child: Container(
                            margin: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircularStepProgressIndicator(
                                      totalSteps: 3,
                                      currentStep: addRecipeProvider.currentStep.index + 1,
                                      stepSize: 8,
                                      selectedColor: Colors.orangeAccent,
                                      unselectedColor: Colors.grey[200],
                                      padding: 0,
                                      width: 100,
                                      height: 100,
                                      selectedStepSize: 10,
                                      roundedCap: (_, __) => true,
                                      child: Center(
                                          child: Text(
                                        "${addRecipeProvider.currentStep.index + 1} of 3",
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 24),
                                        child: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: const [
                                              Text(
                                                "Add Recipe",
                                                style: TextStyle(fontSize: 28),
                                              ),
                                              Text(
                                                "Next: Ingredients",
                                                style: TextStyle(color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: const [
                                              Text(
                                                "Ingredients",
                                                style: TextStyle(fontSize: 28),
                                              ),
                                              Text(
                                                "Next: Methods",
                                                style: TextStyle(color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: const [
                                              Text(
                                                "Methods",
                                                style: TextStyle(fontSize: 28),
                                              ),
                                            ],
                                          )
                                        ][addRecipeProvider.currentStep.index],
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: [
                                      recipeWidget,
                                      ingredientWidget,
                                      methods,
                                    ][addRecipeProvider.currentStep.index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            heroTag: null,
                            onPressed: addRecipeProvider.currentStep == AddRecipeStep.recipe
                                ? null
                                : () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    if (addRecipeProvider.currentStep == AddRecipeStep.ingredients) {
                                      addRecipeProvider.changeCurrentStep(AddRecipeStep.recipe);
                                    } else {
                                      addRecipeProvider.changeCurrentStep(AddRecipeStep.ingredients);
                                    }
                                  },
                            elevation: addRecipeProvider.currentStep == AddRecipeStep.recipe ? 0 : null,
                            backgroundColor: Colors.orangeAccent.withOpacity(addRecipeProvider.currentStep == AddRecipeStep.recipe ? 0.5 : 1),
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.arrow_back),
                          ),
                          FloatingActionButton(
                            heroTag: null,
                            onPressed: addRecipeProvider.currentStep == AddRecipeStep.method
                                ? null
                                : () async {
                                    if (addRecipeProvider.currentStep == AddRecipeStep.recipe) {
                                      if (_nameController.text.trim().isEmpty) {
                                        showErrorMessage(context, errorMessage: "Please enter recipe name");
                                        return;
                                      }
                                      addRecipeProvider.changeCurrentStep(AddRecipeStep.ingredients);
                                    } else {
                                      addRecipeProvider.changeCurrentStep(AddRecipeStep.method);
                                    }
                                  },
                            elevation: addRecipeProvider.currentStep == AddRecipeStep.method ? 0 : null,
                            backgroundColor: Colors.orangeAccent.withOpacity(addRecipeProvider.currentStep == AddRecipeStep.method ? 0.5 : 1),
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        Positioned.fill(child: Consumer<LoaderProvider>(builder: (context, loaderProvider, _) {
          return Visibility(
            visible: loaderProvider.isLoading,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 18),
                          Text("Please wait... \nRecipe is uploading \nto firebase"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }))
      ],
    );
  }
}
