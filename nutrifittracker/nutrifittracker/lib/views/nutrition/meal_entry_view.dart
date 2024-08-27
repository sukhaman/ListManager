import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_bloc.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_event.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_state.dart';
import 'package:nutrifittracker/constants/routes.dart';
import 'package:nutrifittracker/dialogs/error_dialog.dart';
import 'package:nutrifittracker/models/food_entry.dart';
import 'package:nutrifittracker/services/meal_storage.dart';

class MealEntryView extends StatefulWidget {
  const MealEntryView({super.key});

  @override
  State<MealEntryView> createState() => _MealEntryViewState();
}

class _MealEntryViewState extends State<MealEntryView> {
  late final TextEditingController _foodController;
  late final TextEditingController _quantityController;
  String _selectedMealType = 'Breakfast';
  String _foodDescription = '';
  String _quantity = '';
  int _calories = 0;
  double _totalFat = 0.0;
  double _totalProtein = 0.0;
  double _totalCarbohydrates = 0.0;
  Map<String, double> _totalVitaminsAndMinerals = {};
  String previousMealSelected = '';
  DateTime date = DateTime.now();
  final List<Map<String, String>> _foodEntries = [];
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];

  @override
  void initState() {
    _foodController = TextEditingController();
    _quantityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _foodController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _addFoodEntry() {
    if (_foodDescription.isNotEmpty && _quantity.isNotEmpty) {
      setState(() {
        _foodEntries.add({
          'description': _foodDescription.trim(),
          'quantity': _quantity.trim(),
        });
        _foodDescription = '';
        _quantity = '';
        _foodController.clear();
        _quantityController.clear();
      });
    }
  }

  void _fetchNutritionalInfo() async {
    int totalCalories = 0;
    double totalFat = 0.0;
    double totalProtein = 0.0;
    double totalCarbohydrates = 0.0;
    Map<String, double> totalVitaminsAndMinerals = {};
    for (var entry in _foodEntries) {
      try {
        final data = await fetchNutritionalInfo(
            '${entry['quantity']} ${entry['description']}');
        final foodData = data['foods'][0];
        final foodEntry = FoodEntry.fromJson(foodData);

        totalCalories += foodEntry.calories?.toInt() ?? 0;
        totalFat += foodEntry.totalFat ?? 0.0;
        totalProtein += foodEntry.protein ?? 0.0;
        totalCarbohydrates += foodEntry.totalCarbohydrate ?? 0.0;
        foodEntry.vitaminsAndMinerals.forEach((key, value) {
          totalVitaminsAndMinerals[key] =
              (totalVitaminsAndMinerals[key] ?? 0.0) + value!;
          _totalVitaminsAndMinerals = totalVitaminsAndMinerals;
        });
      } catch (e) {
        print('Error fetching nutritional data: $e');
      }
    }

    setState(() {
      _calories = totalCalories;
      _totalFat = totalFat;
      _totalProtein = totalProtein;
      _totalCarbohydrates = totalCarbohydrates;
    });
  }

  void _saveMealEntry() {
    // Save the meal entry to Firebase
    addMealEntry(
      mealType: _selectedMealType,
      calories: _calories,
      totalFat: _totalFat,
      totalProtein: _totalProtein,
      totalCarbohydrates: _totalCarbohydrates,
      vitaminsAndMinerals: _totalVitaminsAndMinerals,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserMealsBloc, UsermealsState>(
        listener: (context, state) {
          if (state is DismissAddMealScreenState) {
            Navigator.of(context).pushNamed(nutritionTrackRoute);
          } else if (state is MealAddedSuccess) {
            showErrorDialog(context, 'Meal entry saved');
          }
          // TODO: implement listener
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<UserMealsBloc>().add(
                                FetchUserMeals(date, previousMealSelected));
                            context
                                .read<UserMealsBloc>()
                                .add(DismissAddNewMealEntry());
                          },
                          icon: const Icon(Icons.arrow_back))
                    ],
                  ),
                  DropdownButton<String>(
                    value: _selectedMealType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMealType = newValue!;
                      });
                    },
                    items: _mealTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _foodController,
                    decoration: const InputDecoration(
                      labelText: 'Food Description',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _foodDescription = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText:
                          'Quantity (e.g., 1 cup, 10 oz, 1/2 glass etc.)',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _quantity = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addFoodEntry,
                    child: const Text('Add Food Entry'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Food Entries:'),
                  for (var entry in _foodEntries)
                    Text('- ${entry['quantity']} ${entry['description']}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchNutritionalInfo,
                    child: const Text('Fetch Nutritional Info'),
                  ),
                  const SizedBox(height: 16),
                  Text('Total Calories: $_calories'),
                  Text('Total Fat: ${_totalFat.toStringAsFixed(2)} g'),
                  Text('Total Protein: ${_totalProtein.toStringAsFixed(2)} g'),
                  Text(
                      'Total Carbohydrates: ${_totalCarbohydrates.toStringAsFixed(2)} g'),
                  const SizedBox(height: 16),
                  const Text(
                    'Vitamins & Minerals',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  for (var vitamin in _totalVitaminsAndMinerals.entries)
                    Text(
                        '${vitamin.key}: ${vitamin.value.toStringAsFixed(2)} mg'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveMealEntry,
                    child: const Text('Save Meal Entry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
