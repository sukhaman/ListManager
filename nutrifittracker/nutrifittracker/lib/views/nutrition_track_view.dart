import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/constants/routes.dart';
import 'package:intl/intl.dart';
import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_bloc.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_event.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_state.dart';

class NutritionTrackView extends StatefulWidget {
  const NutritionTrackView({super.key});

  @override
  State<NutritionTrackView> createState() => _NutritionTrackViewState();
}

class _NutritionTrackViewState extends State<NutritionTrackView>
    with AutomaticKeepAliveClientMixin {
  DateTime selectedDate = DateTime.now();
  final List<String> _mealList = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  String selectedMealType = 'Breakfast';
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context
        .read<UserMealsBloc>()
        .add(FetchUserMeals(selectedDate, selectedMealType));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Daily Nutritions',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add, color: Colors.black),
            onPressed: () {
              //context.read<UserMealsBloc>().add(AddNewMealEntry());
              Navigator.of(context).pushNamed(addNewMealRoute);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildDateSelector(),
            _buildMealTypeSelector(_mealList),
            Expanded(
              child: BlocBuilder<UserMealsBloc, UsermealsState>(
                builder: (context, state) {
                  if (state is UserMealsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserMealLoaded) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: ListView.builder(
                        key: ValueKey(
                            selectedMealType), // Unique key for each meal type
                        padding: const EdgeInsets.all(16.0),
                        itemCount: state.userMeals.length,
                        itemBuilder: (context, index) {
                          final meal = state.userMeals.elementAt(index);
                          return MealNutritionsCard(
                            key: ValueKey(meal.id),
                            meal: meal,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text('Please select a date'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = selectedDate.add(Duration(days: index - 3));
          final isSelected = date == selectedDate;
          return GestureDetector(
            onTap: () {
              if (date != selectedDate) {
                setState(() {
                  selectedDate = date;
                  context
                      .read<UserMealsBloc>()
                      .add(FetchUserMeals(selectedDate, selectedMealType));
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orangeAccent : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('E').format(date)),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealTypeSelector(List<String> mealList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSegmentedControl<int>(
        children: {
          for (int index = 0; index < mealList.length; index++)
            index: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                mealList[index],
                style: const TextStyle(fontSize: 11),
              ),
            ),
        },
        onValueChanged: (int value) {
          if (selectedMealType != mealList[value]) {
            setState(() {
              selectedMealType = mealList[value];
              context
                  .read<UserMealsBloc>()
                  .add(FetchUserMeals(selectedDate, selectedMealType));
            });
          }
        },
        groupValue: mealList.indexOf(selectedMealType),
      ),
    );
  }
}

class MealNutritionsCard extends StatelessWidget {
  final UserMeal meal;
  const MealNutritionsCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /*
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  meal.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              */
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.mealType,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${meal.calories} kcal',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.ellipsis, color: Colors.black),
                onPressed: () {
                  // Options action
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatContainer(
                icon: Icons.restaurant,
                label: '${meal.totalProtein} g',
                type: 'Protein',
                color: Colors.green,
              ),
              StatContainer(
                icon: Icons.local_fire_department,
                label: '${meal.totalCarbohydrates} g',
                type: 'Carbs',
                color: Colors.orange,
              ),
              StatContainer(
                icon: Icons.grain,
                label: '${meal.totalFat} g',
                type: 'Fat',
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VerticalProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color progressColor;

  const VerticalProgressBar({
    super.key,
    required this.progress,
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: progress,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: progressColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}

class StatContainer extends StatelessWidget {
  final IconData icon;
  final String label;
  final String type;
  final Color color;

  const StatContainer({
    Key? key,
    required this.icon,
    required this.label,
    required this.type,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VerticalProgressBar(
              progress: 0.4,
              height: 30,
              width: 5,
              backgroundColor: const Color.fromARGB(255, 228, 224, 224),
              progressColor: color,
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  type,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
