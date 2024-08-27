import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrifittracker/constants/routes.dart';
import 'package:nutrifittracker/views/define_goal_view.dart';

class PersonalHealthInfoView extends StatefulWidget {
  const PersonalHealthInfoView({super.key});

  @override
  State<PersonalHealthInfoView> createState() => _PersonalHealthInfoViewState();
}

class _PersonalHealthInfoViewState extends State<PersonalHealthInfoView> {
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _workoutDaysController;
  int selectedFeet = 5;
  int selectedInches = 7;
  @override
  void initState() {
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _workoutDaysController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _workoutDaysController.dispose();
    super.dispose();
  }

  void _showHeightPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: 250,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 32.0,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedFeet = index + 1;
                            });
                          },
                          scrollController: FixedExtentScrollController(
                              initialItem: selectedFeet - 1),
                          children: List<Widget>.generate(8, (int index) {
                            return Center(child: Text('${index + 1} ft'));
                          }),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 32.0,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedInches = index;
                            });
                          },
                          scrollController: FixedExtentScrollController(
                              initialItem: selectedInches),
                          children: List<Widget>.generate(12, (int index) {
                            return Center(child: Text('$index in'));
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  child: const Text('Done'),
                  onPressed: () {
                    setState(() {
                      _heightController.text =
                          '$selectedFeet ft $selectedInches in';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    const Spacer(), // Pushes the RocketProgressBar to the right
                    const RocketProgressBar(
                      totalSteps: 4,
                      currentStep: 2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ), // Add spacing between the button and the text
                const Text(
                  'Personalize Fitness and Health',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'This information ensures Fitness and Health goals accurate.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Height',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                TextField(
                  controller: _heightController,
                  readOnly: true,
                  onTap: _showHeightPicker,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Weight',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Number of days to workout in one week',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                TextField(
                  controller: _workoutDaysController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 52, 42, 11),
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              mainRoute, // Ensure this matches your route name in MaterialApp
                              (Route<dynamic> route) => false,
                              arguments:
                                  2, // 2 is the index for ProfileView in the bottom navigation
                            );
                          },
                          child: const Text('Continue')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
