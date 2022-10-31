import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_recipe/core/models/recipe_model.dart';
import 'package:cook_recipe/core/providers/all_recipe_provider.dart';
import 'package:cook_recipe/core/services/auth_service.dart';
import 'package:cook_recipe/core/services/firestore_service.dart';
import 'package:cook_recipe/ui/screens/view_recipe/view_recipe_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 12, left: 24),
          child: Text(
            "Welcome \n${FirebaseAuthService.currentUser!.displayName}",
            style: TextStyle(fontSize: 24, color: Colors.orangeAccent),
          ),
        ),
        Expanded(
          child: Consumer<AllRecipeProvider>(
            builder: (context, AllRecipeProvider allRecipeProvider, child) {
              return FutureBuilder<List<RecipeModel>>(
                future: FirestoreService.getRecipe(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Text("Please Add new recipe");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        RecipeModel recipe = snapshot.data![index];
                        return Container(
                          height: MediaQuery.of(context).size.width * 0.4,
                          margin: const EdgeInsets.only(left: 24, top: 24, right: 24),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ViewRecipeScreen(recipe: recipe)));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (recipe.imageUrl != null)
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          height: double.infinity,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
                                            child: CachedNetworkImage(
                                              imageUrl: recipe.imageUrl!,
                                              fit: BoxFit.cover,
                                            ),
                                          )))
                                else
                                  const Expanded(
                                      child: Center(
                                          child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 40,
                                  ))),
                                Expanded(
                                    flex: 3,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: 24,
                                            left: 24,
                                            bottom: 24,
                                            right: 24,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  recipe.recipeName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.group),
                                                    SizedBox(width: 12),
                                                    Text("${recipe.servesNumber} Persons")
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.timer),
                                                    SizedBox(width: 12),
                                                    if (recipe.time != null) Text("${recipe.time} minutes")
                                                  ],
                                                )
                                              ],
                                            )),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
