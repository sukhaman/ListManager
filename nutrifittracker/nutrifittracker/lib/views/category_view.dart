import 'package:flutter/material.dart';
import 'package:nutrifittracker/views/home_view.dart';
import 'package:nutrifittracker/constants/colors.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    final List<ExerciseType> types = [
      ExerciseType(
        name: 'BUTT KICKERS',
        description:
            'While lightly jogging, tap your glutes with your heels. Butt kickers will help warm up your',
        imageUrl: 'lib/images/boxing.jpeg',
      ),
      ExerciseType(
        name: 'LUNGES',
        description:
            'Slowly step one foot forward into a lunge position while dropping your hips toward the floor. Lower your body until your front thigh is parallel to the floor.',
        imageUrl: 'lib/images/boxing.jpeg',
      ),
      ExerciseType(
        name: 'JUMPING JACKS',
        description:
            'From a standing position with your arms by your sides, spread your arms and legs as you jump. Return your arms to your sides and your legs to the starting position with a second jump.',
        imageUrl: 'lib/images/boxing.jpeg',
      ),
      ExerciseType(
        name: 'PLANKS',
        description:
            'Planks can improve your core strength and stability, which are key to protecting your spine while you work out. And, like jumping jacks, planks require no additional equipment and can be performed anywhere.',
        imageUrl: 'lib/images/boxing.jpeg',
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background image
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(category.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 32,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Content below the image
            Container(
              color: CustomColors.terminalYellow,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${category.name} details go here...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${category.name} details go here...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: isSwitched,
                        onChanged: (bool value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: CustomColors.customActiveColor,
                        inactiveThumbColor:
                            CustomColors.customInactiveThumbColor,
                        activeTrackColor: CustomColors.customActiveTrackColor,
                        inactiveTrackColor:
                            CustomColors.customInactiveTrackColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // First List
            Container(
              color: CustomColors.terminalYellow,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First List',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: types
                        .map((type) => Card(
                              child: ListTile(
                                leading: Image.asset(type.imageUrl),
                                title: Text(type.name),
                                subtitle: Text(type.description),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Second List
            Container(
              color: CustomColors.terminalYellow,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Second List',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: types
                        .map((type) => Card(
                              child: ListTile(
                                leading: Image.asset(type.imageUrl),
                                title: Text(type.name),
                                subtitle: Text(type.description),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseType {
  final String name;
  final String description;
  final String imageUrl;

  ExerciseType({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class CustomColors {
  static const terminalYellow = Color(0xFFE0AF68); // Example color
  static const customActiveColor = Color(0xFF4CAF50);
  static const customInactiveThumbColor = Color(0xFFB0BEC5);
  static const customActiveTrackColor = Color(0xFF4CAF50);
  static const customInactiveTrackColor = Color(0xFFB0BEC5);
}
