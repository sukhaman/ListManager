import 'package:flutter/material.dart';

class ActivityListView extends StatefulWidget {
  @override
  State<ActivityListView> createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  final List<Activity> activities = [
    Activity("Afternoon Run", "Lower Saxony", 6.4, 85, 2, 27,
        Icons.directions_run, Colors.green, "5:29 PM"),
    Activity("Night Ride", "Hamburg", 15.6, 32, 1, 3, Icons.directions_bike,
        Colors.purple, "8:16 PM"),
    Activity("Afternoon Run", "Lower Saxony", 2.5, 5, 0, 45,
        Icons.directions_run, Colors.green, "5:29 PM"),
    Activity("Morning Ride", "Hamburg", 2.0, 8, 0, 45, Icons.directions_bike,
        Colors.purple, "7:10 AM",
        yesterday: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Activity',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              // Use Expanded to make ListView take up remaining space
              Expanded(
                child: ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return ActivityTile(activity: activity);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final Activity activity;

  const ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: activity.yesterday ? Colors.grey[200] : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: activity.color,
            child: Icon(activity.icon, color: Colors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${activity.name} • ${activity.location}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text('Distance: ${activity.distance} km')),
                    SizedBox(width: 8),
                    Expanded(child: Text('Elev Gain: ${activity.elevation} m')),
                    SizedBox(width: 8),
                    Expanded(
                      child:
                          Text('Time: ${activity.hours}h ${activity.minutes}m'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Text(activity.time),
        ],
      ),
    );
  }
}

class Activity {
  final String name;
  final String location;
  final double distance;
  final int elevation;
  final int hours;
  final int minutes;
  final IconData icon;
  final Color color;
  final String time;
  final bool yesterday;

  Activity(this.name, this.location, this.distance, this.elevation, this.hours,
      this.minutes, this.icon, this.color, this.time,
      {this.yesterday = false});
}
