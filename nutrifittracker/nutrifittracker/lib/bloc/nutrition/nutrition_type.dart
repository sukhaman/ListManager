import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';

class UserMeal {
  final String id;
  final DateTime date;
  final String mealType;
  final double calories;
  final double totalFat;
  final double totalProtein;
  final double totalCarbohydrates;
  final Map<String, double>
      vitaminsAndMinerals; // Updated to Map<String, double>
  final String ownerId;

  UserMeal({
    required this.id,
    required this.date,
    required this.mealType,
    required this.calories,
    required this.totalFat,
    required this.totalProtein,
    required this.totalCarbohydrates,
    required this.vitaminsAndMinerals, // Updated to Map<String, double>
    required this.ownerId,
  });

  // Factory constructor to create a UserMeal object from a Firestore snapshot
  factory UserMeal.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserMeal(
      id: (snapshot.id),
      date: (data['date'] as Timestamp).toDate(),
      mealType: data['mealType'] as String,
      calories: (data['calories'] as num).toDouble(),
      totalFat: (data['totalFat'] as num).toDouble(),
      totalProtein: (data['totalProtein'] as num).toDouble(),
      totalCarbohydrates: (data['totalCarbohydrates'] as num).toDouble(),
      vitaminsAndMinerals: (data['vitaminsAndMinerals']
              as Map<String, dynamic>) // Updated to Map<String, double>
          .map((key, value) => MapEntry(
              key, (value as num).toDouble())), // Convert all values to double
      ownerId: data['owner_id'] as String,
    );
  }
}

class NutritionType {
  final String name;
  final String description;
  final List<Source>? sources;

  NutritionType({
    required this.name,
    required this.description,
    this.sources,
  });

  factory NutritionType.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    // Safely getting name and description
    final name = data['name'] as String;
    final description = data['description'] as String;

    // Safely getting sources
    final sourcesData = data['sources'] as Map<String, dynamic>?;

    // If sourcesData is not null, process it; otherwise, set sources to null
    final List<Source>? sources = sourcesData?.entries.map((entry) {
      final foodData = entry.value as List<dynamic>;
      final List<Food> foods = foodData.map((foodItem) {
        final foodMap = foodItem as Map<String, dynamic>;
        return Food(
          name: foodMap['name'] as String,
          serving: foodMap['serving']?.toString(),
        );
      }).toList();
      return Source(Food: foods);
    }).toList();

    return NutritionType(
      name: name,
      description: description,
      sources: sources,
    );
  }
}

class Source {
  final List Food;

  Source({required this.Food});
}

class Food {
  final String name;
  final String? serving;

  Food({required this.name, this.serving});
}
