import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BodyCloudStorage {
  Future<void> addBodyEntry({
    required int age,
    required String gender,
    required int heightInFeet,
    required int heightInInches,
    required int weight,
  }) async {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final bodyData = {
        'age': age,
        'gender': gender,
        'height_feet': heightInFeet,
        'height_inches': heightInInches,
        'weight': weight,
        'owner_id':
            currentUser.uid, // Set the owner ID to the current user's UID
      };

      // Reference to the user's document
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

      // Add a new meal entry to the user's "body" subcollection
      await userDoc.collection('userBody').add(bodyData);
    } else {
      throw Exception('User is not logged in');
    }
  }
}
