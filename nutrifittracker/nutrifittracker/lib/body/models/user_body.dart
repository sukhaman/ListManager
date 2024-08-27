import 'package:cloud_firestore/cloud_firestore.dart';

class UserBody {
  final int age;
  final String gender;
  final int heightInFeet;
  final int heightInInches;
  final int weight;

  UserBody({
    required this.age,
    required this.gender,
    required this.heightInFeet,
    required this.heightInInches,
    required this.weight,
  });

  // Make sure this method is correctly defined in the Meal class
  factory UserBody.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserBody(
      age: data['name'] ?? '',
      gender: data['gender'] ?? '',
      heightInFeet: data['height_feet'] ?? '',
      heightInInches: data['height_inches'] ?? '',
      weight: data['weight'] ?? '',
    );
  }
}
