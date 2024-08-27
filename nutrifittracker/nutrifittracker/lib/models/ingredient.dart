class Ingredient {
  final String name;
  final String quantity;
  final String? protein;
  final String? fat;
  final String? carbohydrates;
  final String? calories;
  final String? vitamins;
  final String? fiber;

  Ingredient({
    required this.name,
    required this.quantity,
    this.protein,
    this.fat,
    this.carbohydrates,
    this.calories,
    this.vitamins,
    this.fiber,
  });

  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? '',
      protein: data['protein'],
      fat: data['fat'],
      carbohydrates: data['carbohydrates'],
      calories: data['calories'],
      vitamins: data['vitamins'],
      fiber: data['fiber'],
    );
  }
}
