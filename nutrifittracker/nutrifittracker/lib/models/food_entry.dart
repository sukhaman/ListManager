class FoodEntry {
  final String foodName;
  final double servingQty;
  final String servingUnit;
  final double? servingWeightGrams;
  final double calories;
  final double? totalFat;
  final double? saturatedFat;
  final double? cholesterol;
  final double? sodium;
  final double? totalCarbohydrate;
  final double? dietaryFiber;
  final double? sugars;
  final double? protein;
  final Map<String, double?> vitaminsAndMinerals;

  FoodEntry({
    required this.foodName,
    required this.servingQty,
    required this.servingUnit,
    required this.servingWeightGrams,
    required this.calories,
    required this.totalFat,
    required this.saturatedFat,
    required this.cholesterol,
    required this.sodium,
    required this.totalCarbohydrate,
    required this.dietaryFiber,
    required this.sugars,
    required this.protein,
    required this.vitaminsAndMinerals,
  });

  factory FoodEntry.fromJson(Map<String, dynamic> json) {
    // Initialize the vitamins and minerals map
    Map<String, double?> vitaminsAndMinerals = {};

    // Iterate through the full nutrients list and add each to the map
    if (json['full_nutrients'] != null) {
      for (var nutrient in json['full_nutrients']) {
        int attrId = nutrient['attr_id'];
        double value = nutrient['value'].toDouble();

        // Map attr_id to vitamin/mineral name (you can extend this mapping as needed)
        String? nutrientName = _getNutrientName(attrId);
        if (nutrientName != null) {
          vitaminsAndMinerals[nutrientName] = value;
        }
      }
    }

    return FoodEntry(
      foodName: json['food_name'],
      servingQty: json['serving_qty'].toDouble(),
      servingUnit: json['serving_unit'],
      servingWeightGrams: json['serving_weight_grams']?.toDouble(),
      calories: json['nf_calories']?.toDouble(),
      totalFat: json['nf_total_fat']?.toDouble(),
      saturatedFat: json['nf_saturated_fat']?.toDouble(),
      cholesterol: json['nf_cholesterol']?.toDouble(),
      sodium: json['nf_sodium']?.toDouble(),
      totalCarbohydrate: json['nf_total_carbohydrate']?.toDouble(),
      dietaryFiber: json['nf_dietary_fiber']?.toDouble(),
      sugars: json['nf_sugars']?.toDouble(),
      protein: json['nf_protein']?.toDouble(),
      vitaminsAndMinerals: vitaminsAndMinerals,
    );
  }

  // Helper function to map attr_id to nutrient names
  static String? _getNutrientName(int attrId) {
    switch (attrId) {
      case 301:
        return 'Calcium';
      case 303:
        return 'Iron';
      case 304:
        return 'Magnesium';
      case 305:
        return 'Phosphorus';
      case 306:
        return 'Potassium';
      case 307:
        return 'Sodium';
      case 309:
        return 'Zinc';
      case 401:
        return 'Vitamin C';
      case 404:
        return 'Thiamin';
      case 405:
        return 'Riboflavin';
      case 406:
        return 'Niacin';
      case 410:
        return 'Pantothenic acid';
      case 415:
        return 'Vitamin B6';
      case 417:
        return 'Folate';
      case 418:
        return 'Vitamin B12';
      case 430:
        return 'Vitamin K';
      case 431:
        return 'Folic acid';
      case 432:
        return 'Dietary folate equivalents';
      case 435:
        return 'Folate, food';
      case 601:
        return 'Cholesterol';
      case 606:
        return 'Saturated fat';
      // Add more cases as needed
      default:
        return null; // If attr_id does not match, return null
    }
  }
}
