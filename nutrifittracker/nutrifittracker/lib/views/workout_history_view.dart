import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryView extends StatefulWidget {
  const WorkoutHistoryView({super.key});

  @override
  State<WorkoutHistoryView> createState() => _WorkoutHistoryViewState();
}

class _WorkoutHistoryViewState extends State<WorkoutHistoryView> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedMonth = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _scrollToSelectedDate() {
    final int day = _selectedDate.day;
    final double position = (day - 1) * 64.0; // 60 (width) + 4 (margin) * 2
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Spacer(),
                  TextButton.icon(
                    icon: Icon(Icons.arrow_drop_down),
                    label: Text(DateFormat('MMMM yyyy').format(_focusedMonth)),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _focusedMonth,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (selectedDate != null) {
                        setState(() {
                          _focusedMonth =
                              DateTime(selectedDate.year, selectedDate.month);
                        });
                      }
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 90, // Set a constant height for the date boxes
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: daysInMonth,
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final date =
                      DateTime(_focusedMonth.year, _focusedMonth.month, day);
                  final isSelected = date == _selectedDate;
                  final isToday = date == DateTime.now();

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                        _scrollToSelectedDate();
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.grey[850],
                        borderRadius: BorderRadius.circular(10),
                        border: isToday
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('E').format(date),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            day.toString().padLeft(2, '0'),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text("Today's date"),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 100,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('lib/images/dark.jpg'),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(12), // Border radius
              ),
              child: const Align(
                alignment: Alignment
                    .center, // Aligning the content to the center of the image
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Center the columns vertically
                  children: [
                    Spacer(), // Add a Spacer before the first column
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Align content to the center of the column
                      children: [
                        Text(
                          "Calories\nBurns",
                          textAlign: TextAlign
                              .center, // Center the text inside the column
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5), // Spacing between texts
                        Text(
                          '323 kcal',
                          textAlign: TextAlign
                              .center, // Center the text inside the column
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Add a Spacer between the first and second columns
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Distance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5), // Spacing between texts
                        Text(
                          '\n2.5 miles',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Add a Spacer between the second and third columns
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Steps",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5), // Spacing between texts
                        Text(
                          '\n3723 steps',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Add a Spacer after the last column
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const WorkoutCard(),
          ],
        ),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Running',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Today  06.30 AM',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Space between items
            children: [
              Expanded(
                child: StatContainer(
                  icon: Icons.local_fire_department,
                  label: '465 kCal',
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 8), // Space between items
              Expanded(
                child: StatContainer(
                  icon: Icons.timer,
                  label: '1 h 23 min',
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 8), // Space between items
              Expanded(
                child: StatContainer(
                  icon: Icons.alt_route,
                  label: '5.6 km',
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatContainer extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const StatContainer({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 15,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
