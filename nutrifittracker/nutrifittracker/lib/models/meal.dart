import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrifittracker/models/ingredient.dart';

class Meal {
  final String name;
  final String description;
  final List<Ingredient> ingredients;
  final String type;
  final String calories;
  final String time;
  final List<String>? instructions;
  final List<String>? benefits;
  final String photoBy;

  Meal({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.type,
    required this.calories,
    required this.time,
    required this.instructions,
    required this.benefits,
    required this.photoBy,
  });

  @override
  String toString() {
    return 'Meal{name: $name, description: $description, type: $type, ingredients: $ingredients}';
  }

  // Make sure this method is correctly defined in the Meal class
  factory Meal.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Handle the 'ingredients' field
    var ingredientsData = data['ingredients'] as List<dynamic>? ?? [];
    List<Ingredient> ingredientsList = ingredientsData
        .map((ingredient) => Ingredient.fromMap(ingredient))
        .toList();

    // Handle the 'instructions' field
    var instructionsData = data['instructions'] as List<dynamic>? ?? [];
    List<String> instructionsList =
        instructionsData.map((instruction) => instruction as String).toList();
    // Handle the 'instructions' field
    var benefitssData = data['benefits'] as List<dynamic>? ?? [];
    List<String> benefitssList =
        benefitssData.map((benefit) => benefit as String).toList();

    return Meal(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      ingredients: ingredientsList,
      type: data['type'] ?? '',
      calories: data['calories'] ?? '',
      time: data['time'] ?? '',
      instructions: instructionsList,
      benefits: benefitssList,
      photoBy: data['photo_by'] ?? '',
    );
  }
}
