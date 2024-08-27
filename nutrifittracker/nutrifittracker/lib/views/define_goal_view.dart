import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nutrifittracker/constants/routes.dart';

class DefineGoalView extends StatefulWidget {
  const DefineGoalView({super.key});

  @override
  State<DefineGoalView> createState() => _DefineGoalViewState();
}

class _DefineGoalViewState extends State<DefineGoalView> {
  int? selectedIndex; // Variable to keep track of the selected index
  @override
  Widget build(BuildContext context) {
    final List<GoalType> goalTypes = [
      GoalType(
          title: 'Weight loss',
          description: 'Burn calroies and get ideal body',
          icon: Icons.sports_gymnastics),
      GoalType(
          title: 'Gain Muscle',
          description: 'Gain muscle strength',
          icon: Icons.line_weight),
      GoalType(
          title: 'Get fitter',
          description: 'Feel more healthy',
          icon: Icons.sports_handball)
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Spacer(), // Pushes the RocketProgressBar to the right
                        const RocketProgressBar(
                          totalSteps: 4,
                          currentStep: 1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ), // Add spacing between the button and the text
                    const Text(
                      'What are your exercise goals?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Let's define your goals and will help you achieve it.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: goalTypes.length,
                      itemBuilder: (context, index) {
                        final goalType = goalTypes[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex =
                                  index; // Update the selected index
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: GoalView(
                              goalType: goalType,
                              selected: selectedIndex ==
                                  index, // Pass the selected state
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(personalHealthInfoRoute);
                          },
                          child: const Text('Continue')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RocketProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const RocketProgressBar(
      {super.key, required this.totalSteps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: CustomPaint(
              painter: ProgressPainter(
                  totalSteps: totalSteps, currentStep: currentStep),
            ),
          ),
          const Icon(
            Icons.rocket_launch, // Rocket icon
            color: Colors.orange,
            size: 15,
          ),
        ],
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final int totalSteps;
  final int currentStep;

  ProgressPainter({required this.totalSteps, required this.currentStep});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final progressPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final sweepAngle = 2 * pi / totalSteps;
    final gapSize = 0.5; // Adjust the gap size between segments

    // Draw background segments with gaps
    for (int i = 0; i < totalSteps; i++) {
      final startAngle = i * sweepAngle - pi / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle - gapSize, // Create gap by reducing the sweep angle
        false,
        paint,
      );
    }

    // Draw progress segments with gaps
    for (int i = 0; i < currentStep; i++) {
      final startAngle = i * sweepAngle - pi / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle - gapSize, // Create gap by reducing the sweep angle
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GoalView extends StatefulWidget {
  final GoalType goalType;
  final bool selected; // New parameter to indicate selection
  const GoalView({super.key, required this.goalType, required this.selected});

  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width -
            40, // Adjust width to be responsive
        height: 90, // Fixed height
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(10), // Rounded corners
          border: Border.all(
            color: widget.selected
                ? Colors.blue
                : Colors.transparent, // Highlight border if selected
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withOpacity(0.5), // Shadow color with higher opacity
              spreadRadius: 5, // Shadow spread radius
              blurRadius: 10, // Shadow blur radius
              offset: const Offset(0, 5), // Shadow offset
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.goalType.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4), // Spacing between the texts
                  Text(
                    widget.goalType.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              widget.goalType.icon,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class GoalType {
  final String title;
  final String description;
  final IconData icon;

  GoalType({
    required this.title,
    required this.description,
    required this.icon,
  });
}
