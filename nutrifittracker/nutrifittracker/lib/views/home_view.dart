import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrifittracker/constants/routes.dart';
import 'package:nutrifittracker/services/videos/video_url.dart';
import 'package:video_player/video_player.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _fetchVideoURL();
  }

  Future<void> _fetchVideoURL() async {
    try {
      await getFileURL('bench_press.mp4');
    } catch (e) {
      print('Error fetching video URL: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Text(
              'Hire the best talent across the world.',
              textAlign: TextAlign.center, // Center the text
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make the text bold
                fontSize: 22.0, // You can set the font size as needed
              ),
            ),
            SizedBox(
                height: 20), // Add some space between the text and the list
            WorkoutCard(),
            SizedBox(height: 20),
            CategoriesCard(),
          ],
        ),
      ),
    );
  }
}

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({super.key});

  @override
  _WorkoutCardState createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  late VideoPlayerController _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _fetchVideoURL();
  }

  Future<void> _fetchVideoURL() async {
    try {
      // Replace with your own method to get the video URL
      String videoUrlString = await getFileURL('bench_press.mp4');

      Uri videoUrl = Uri.parse(videoUrlString);
      _controller = VideoPlayerController.networkUrl(videoUrl)
        ..setLooping(true);

      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    } catch (e) {
      print('Error fetching video URL: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.9;

    return Container(
      width: cardWidth,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                // Video background
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                // Overlay content
                Positioned(
                  top: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: const Text(
                          'Day 12',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Strength',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jaydon Kenter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                '25 min',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.flash_on, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                '530 kcal',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate the width of the card based on the device's screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        screenWidth * 0.9; // Adjust this percentage as needed

    final List<Category> categories = [
      Category(
        name: 'Cardio',
        backgroundColor: Colors.redAccent,
        imageUrl: 'lib/images/cardio.jpeg',
      ),
      Category(
        name: 'Yoga',
        backgroundColor: Colors.blueAccent,
        imageUrl: 'lib/images/yoga.jpeg',
      ),
      Category(
        name: 'Boxing',
        backgroundColor: Colors.greenAccent,
        imageUrl: 'lib/images/boxing.jpeg',
      ),
      // Add more categories as needed
    ];

    return Container(
      width: cardWidth,
      height: 200, // Increased height to accommodate ListView
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white, // Set background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, // Set shadow color
            blurRadius: 10, // Set shadow blur radius
            offset: Offset(0, 5), // Set shadow offset
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              color: Color(0xFF0F0E0E),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    categories.length, // Use the length of the categories list
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(categoryRoute, arguments: category);
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(category.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 242, 232, 232),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final Color backgroundColor;
  final String imageUrl;

  Category({
    required this.name,
    required this.backgroundColor,
    required this.imageUrl,
  });
}
