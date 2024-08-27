import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';

class UserMealCloudStorage {
  Stream<Iterable<UserMeal>> getMealsForUser(DateTime date, String mealType) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("User is not logged in");
    }

    final startOfDay =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day));
    final endOfDay = Timestamp.fromDate(
        DateTime(date.year, date.month, date.day, 23, 59, 59));
// Reference to the user's document
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

    // Get all documents from the "meals" subcollection

    return userDoc
        .collection('userMeals')
        .where('mealType', isEqualTo: mealType)
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .where('date', isLessThanOrEqualTo: endOfDay)
        .snapshots()
        .map((snapshot) {
      // Print the entire snapshot
      // print('Snapshot data: ${snapshot.docs}');

      // Print individual documents in the snapshot
      snapshot.docs.forEach((doc) {
        // print('Document ID: ${doc.id}');
        // print('Document Data: ${doc.data()}');
      });

      // Convert the snapshot into UserMeal objects
      return snapshot.docs.map((doc) => UserMeal.fromSnapshot(doc));
    });
  }
}
