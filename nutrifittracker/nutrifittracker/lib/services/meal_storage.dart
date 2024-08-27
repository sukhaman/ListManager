import 'dart:convert' as convert;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> _saveMealEntry(
  String mealType,
  String foodDescription,
  String quantity,
  String calories,
) async {
  final firestore = FirebaseFirestore.instance;
  await firestore.collection('mealCalories').add({
    'mealType': mealType,
    'foodDescription': foodDescription,
    'quantity': quantity,
    'calories': calories,
    'date': DateTime.now(),
  });
}

Future<int> getCalories(String foodDescription) async {
  final data = await fetchNutritionalInfo(foodDescription);

  if (data['foods'] != null && data['foods'].isNotEmpty) {
    final calories = data['foods'][0]['nf_calories'];
    return calories.toInt();
  } else {
    throw Exception('No nutritional information found');
  }
}

Future<Map<String, dynamic>> fetchNutritionalInfo(
    String foodDescription) async {
  final apiKey = dotenv.env['API_KEY'] ?? '';
  final appId = dotenv.env['APP_ID'] ?? '';
  const url = 'https://trackapi.nutritionix.com/v2/natural/nutrients';
  final Map<String, String> headers = {
    'x-app-id': appId,
    'x-app-key': apiKey,
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };
  final body = jsonEncode({'query': foodDescription});

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    //print(data);
    return data;
  } else {
    throw Exception('Failed to fetch nutritional data');
  }
}

Future<void> addMealEntry({
  required String mealType,
  required int calories,
  required double totalFat,
  required double totalProtein,
  required double totalCarbohydrates,
  required Map<String, double> vitaminsAndMinerals,
}) async {
  // Get the current user
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    final mealData = {
      'date': FieldValue.serverTimestamp(), // Automatically set to server time
      'mealType': mealType,
      'calories': calories,
      'totalFat': totalFat,
      'totalProtein': totalProtein,
      'totalCarbohydrates': totalCarbohydrates,
      'vitaminsAndMinerals': vitaminsAndMinerals,
      'owner_id': currentUser.uid, // Set the owner ID to the current user's UID
    };

    // Reference to the user's document
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

    // Add a new meal entry to the user's "meals" subcollection
    await userDoc.collection('userMeals').add(mealData);
  } else {
    throw Exception('User is not logged in');
  }
}
