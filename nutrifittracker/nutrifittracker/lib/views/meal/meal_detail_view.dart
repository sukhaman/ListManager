import 'package:flutter/material.dart';
import 'package:nutrifittracker/models/meal.dart';
import 'package:nutrifittracker/services/videos/video_url.dart';

class MealDetailView extends StatelessWidget {
  final Meal meal;

  const MealDetailView({Key? key, required this.meal}) : super(key: key);

  Future<String> _getImageURL() async {
    String imageUrl = await getFileURL('mealphotos/${meal.name}.jpg');
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  FutureBuilder<String>(
                    future: _getImageURL(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey,
                          child: const Center(
                            child:
                                Icon(Icons.error, color: Colors.red, size: 50),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return Stack(
                          children: [
                            Image.network(
                              snapshot.data!,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                color: Colors.black.withOpacity(0.5),
                                child: Text(
                                  meal.photoBy,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey,
                        );
                      }
                    },
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      meal.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ExpansionTile(
                      title: const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: meal.ingredients.map((ingredient) {
                        return ExpansionTile(
                          title: Text(
                            '${ingredient.name} (${ingredient.quantity})',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Protein: ${ingredient.protein}'),
                                  Text('Fiber: ${ingredient.fiber}'),
                                  Text(
                                      'Carbohydrates: ${ingredient.carbohydrates}'),
                                  Text('Fat: ${ingredient.fat}'),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    // Check if instructions exist and display them
                    if (meal.instructions != null &&
                        meal.instructions!.isNotEmpty)
                      ExpansionTile(
                        title: const Text(
                          'Instructions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: meal.instructions!.map((instruction) {
                          return ListTile(
                            title: Text(instruction),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 16),
                    // Check if instructions exist and display them
                    if (meal.instructions != null &&
                        meal.instructions!.isNotEmpty)
                      ExpansionTile(
                        title: const Text(
                          'Benefits',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: meal.benefits!.map((benefit) {
                          return ListTile(
                            title: Text(benefit),
                          );
                        }).toList(),
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
