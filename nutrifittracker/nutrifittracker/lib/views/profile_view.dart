import 'package:flutter/material.dart';
import 'package:nutrifittracker/constants/routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const SafeArea(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'lib/images/profile_image.jpg'), // Replace with your image asset path
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tom Harty',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfileInfo(label: '29y', value: 'Year'),
                        ProfileInfo(label: 'Male', value: 'Gender'),
                        ProfileInfo(label: '6.1 Feet', value: 'Height'),
                        ProfileInfo(label: '192.6 lbs', value: 'Weight'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Progress Card
            Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timeline, color: Colors.orange.shade300),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lose 20 lbs In 4 Months',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              '22.2% Progress',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Menu Items
            MenuItem(
              icon: Icons.flag,
              color: Colors.purpleAccent,
              text: 'Goals',
              onTap: () {
                // Navigate to Goals Screen
                Navigator.of(context).pushNamed(defineExerciseGoalRoute);
              },
            ),
            MenuItem(
              icon: Icons.history,
              color: Colors.blueAccent,
              text: 'Workout History',
              onTap: () {
                // Navigate to Workout History Screen
                Navigator.of(context).pushNamed(workoutHistoryRoute);
              },
            ),
            MenuItem(
              icon: Icons.track_changes,
              color: Colors.orangeAccent,
              text: 'Activity Tracking',
              onTap: () {
                // Navigate to Activity Tracking Screen
                Navigator.of(context).pushNamed(activityTrackingRoute);
              },
            ),
            MenuItem(
              icon: Icons.restaurant,
              color: Colors.teal,
              text: 'Nutrition Tracking',
              onTap: () {
                // Navigate to Nutrition Tracking Screen
                Navigator.of(context).pushNamed(nutritionTrackRoute);
              },
            ),
            MenuItem(
              icon: Icons.fitness_center,
              color: Colors.lightBlue,
              text: 'My Body',
              onTap: () {
                // Navigate to My Body Screen
                Navigator.of(context).pushNamed(myBodyRoute);
              },
            ),
            MenuItem(
              icon: Icons.settings,
              color: Colors.grey,
              text: 'Settings',
              onTap: () {
                // Navigate to Settings Screen
                Navigator.of(context).pushNamed(profileSetttingsRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onTap;

  const MenuItem({
    required this.icon,
    required this.color,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18),
          ],
        ),
      ),
    );
  }
}
