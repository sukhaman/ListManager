import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/bloc/meal/meal_bloc.dart';
import 'package:nutrifittracker/bloc/meal/meal_cloud_storge.dart';
import 'package:nutrifittracker/bloc/meal/meal_event.dart';
import 'package:nutrifittracker/bloc/meal/meal_state.dart';
import 'package:nutrifittracker/models/meal.dart';
import 'package:nutrifittracker/models/meal_type.dart';
import 'package:nutrifittracker/views/meal/meal_detail_view.dart';

class MealsView extends StatefulWidget {
  const MealsView({super.key});

  @override
  _MealsViewState createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  List<MealType> types = [
    MealType(name: 'All'),
    MealType(name: 'Breakfast'),
    MealType(name: 'Lunch'),
    MealType(name: 'Dinner'),
    MealType(name: 'Snack'),
  ];

  String selectedMealType = 'All'; // Initial selected meal type

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MealBloc(mealCloudStorage: MealCloudStorge())..add(FetchMeals()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<MealBloc, MealState>(
            builder: (context, state) {
              if (state is MealLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MealLoaded) {
                // Filter meal list based on selected meal type
                Iterable<Meal> filteredMeals = selectedMealType == 'All'
                    ? state.meals
                    : state.meals
                        .where((meal) => meal.type == selectedMealType)
                        .toList();

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Best recipes\nfor you',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildMealTypeSelector(),
                        const SizedBox(height: 10),
                        _buildMealList(filteredMeals),
                      ],
                    ),
                  ),
                );
              } else if (state is MealError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: Text('No meals found'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMealTypeSelector() {
    return Container(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
          final textWidth = calculateTextWidth(type.name);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMealType = type.name;
              });
            },
            child: Container(
              width: textWidth + 32,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: selectedMealType == type.name
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular((textWidth + 32) / 2),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  type.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealList(Iterable<Meal> meals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          meals.map((meal) => Card(child: MealPreview(meal: meal))).toList(),
    );
  }

  double calculateTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}

class MealPreview extends StatelessWidget {
  final Meal meal;
  const MealPreview({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailView(meal: meal),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(meal.type),
                        const SizedBox(width: 10),
                        Text('Time: ${meal.time}'),
                        const SizedBox(width: 10),
                        Text(meal.calories),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
