import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrifittracker/models/meal.dart';

class MealCloudStorge {
  final meals = FirebaseFirestore.instance.collection('meals');

  Stream<Iterable<Meal>> allMeals() {
    return meals.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Meal.fromFirestore(doc));
    });
  }
}
