import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_recipe/core/models/method_model.dart';

class RecipeModel {
  final String recipeName;
  final String? imageUrl;
  final int servesNumber;
  final int? time;
  final List<String> ingredients;
  final List<MethodModel> methods;

  RecipeModel({
    required this.recipeName,
    required this.imageUrl,
    required this.servesNumber,
    required this.time,
    required this.ingredients,
    required this.methods,
  });

  RecipeModel.fromJson(Map<String, dynamic> json)
      : recipeName = json['recipeName'],
        imageUrl = json['imageUrl'],
        servesNumber = json['servesNumber'],
        time = json['time'],
        ingredients = (json['ingredients'] as Iterable?)?.map((e) => e.toString()).toList() ?? [],
        methods = (json['methods'] as Iterable?)?.map((e) => MethodModel.fromJson(e)).toList() ?? [];

  factory RecipeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data();
    return RecipeModel(
      recipeName: json?['recipeName'],
      imageUrl: json?['imageUrl'],
      servesNumber: json?['servesNumber'],
      time: json?['time'],
      ingredients: (json?['ingredients'] as Iterable?)?.map((e) => e.toString()).toList() ?? [],
      methods: (json?['methods'] as Iterable?)?.map((e) => MethodModel.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'recipeName': recipeName,
        'imageUrl': imageUrl,
        'servesNumber': servesNumber,
        'time': time,
        'ingredients': ingredients,
        'methods': methods.map((e) => e.toJson()).toList(),
      };

  RecipeModel copyWith({
    String? recipeName,
    String? imageUrl,
    int? servesNumber,
    int? time,
    List<String>? ingredients,
    List<MethodModel>? methods,
  }) {
    return RecipeModel(
      recipeName: recipeName ?? this.recipeName,
      imageUrl: imageUrl ?? this.imageUrl,
      servesNumber: servesNumber ?? this.servesNumber,
      time: time ?? this.time,
      ingredients: ingredients ?? this.ingredients,
      methods: methods ?? this.methods,
    );
  }

  @override
  int get hashCode => recipeName.hashCode ^ imageUrl.hashCode ^ servesNumber.hashCode ^ time.hashCode ^ ingredients.hashCode ^ methods.hashCode;

  @override
  bool operator ==(Object other) {
    return other is RecipeModel && other.hashCode == hashCode;
  }
}
