import 'package:cached_network_image/cached_network_image.dart';
import 'package:cook_recipe/core/models/recipe_model.dart';
import 'package:flutter/material.dart';

class ViewRecipeScreen extends StatelessWidget {
  const ViewRecipeScreen({super.key, required this.recipe});
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${recipe.recipeName}"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (recipe.imageUrl != null)
                SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        imageUrl: recipe.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ))
              else
                Center(
                    child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 160,
                )),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    "Serve",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 18),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    "${recipe.servesNumber} ",
                    style: const TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (recipe.time != null) const Spacer(),
                  if (recipe.time != null)
                    const Text(
                      "Time",
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 18),
                    ),
                  if (recipe.time != null) const SizedBox(width: 24),
                  if (recipe.time != null)
                    Text(
                      "${recipe.time} Minutes",
                      style: const TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Ingredients",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...recipe.ingredients
                  .map((e) => ListTile(
                        title: Text(e),
                      ))
                  .toList(),
              const SizedBox(height: 24),
              const Text(
                "Methods/Steps",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...recipe.methods
                  .map(
                    (e) => SizedBox(
                      height: 60,
                      key: Key(e.hashCode.toString()),
                      child: Container(
                        height: 52,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              "${recipe.methods.indexOf(e) + 1}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 12),
                            if (e.imageUrl != null)
                              Container(
                                  height: 56,
                                  width: 56,
                                  margin: const EdgeInsets.only(right: 12),
                                  child: CachedNetworkImage(
                                    imageUrl: e.imageUrl!,
                                    fit: BoxFit.cover,
                                  )),
                            Expanded(
                              child: Text(
                                e.method,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      )),
    );
  }
}
