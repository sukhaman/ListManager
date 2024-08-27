import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';

class NutritionCloudStorage {
  final nutritions = FirebaseFirestore.instance.collection('nutritionList');
  Stream<Iterable<NutritionType>> allNutritions() {
    return nutritions.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => NutritionType.fromSnapshot(doc));
    });
  }
}
