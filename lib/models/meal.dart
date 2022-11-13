class Meal{
  String id;
  String name;
  String imageUrl;
  double rating;
  Map<String,double> deals;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.deals,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      deals: json['deals'],
    );
  }
}