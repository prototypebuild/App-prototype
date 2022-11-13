class Outlet{
  String id;
  String name;
  String location;
  double rating;
  String bannerUrl;
  bool isOpen;

  Outlet({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.bannerUrl,
    required this.isOpen,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      rating: json['rating'],
      bannerUrl: json['bannerUrl'],
      isOpen: json['isOpen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'rating': rating,
      'bannerUrl': bannerUrl,
      'isOpen': isOpen,
    };
  }
}