import '../models/outlet.dart';

class FakeApiManager {
  static final FakeApiManager _instance = FakeApiManager._internal();
  factory FakeApiManager() => _instance;
  FakeApiManager._internal();

  // fake data..
  List<Outlet> _outlets = [
    Outlet(
      id: "1",
      name: "Burger King",
      location: "Sector 29, Gurgaon",
      rating: 4.5,
      bannerUrl: "https://i.ibb.co/0nQqZ1w/burger-king.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "2",
      name: "McDonald's",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://i.ibb.co/0nQqZ1w/burger-king.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "3",
      name: "KFC",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://i.ibb.co/0nQqZ1w/burger-king.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "4",
      name: "Subway",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://i.ibb.co/0nQqZ1w/burger-king.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "5",
      name: "Domino's",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://i.ibb.co/0nQqZ1w/burger-king.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "6",
      name: "Pizza Hut",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://i.ibb.co/0nQqZ1w/burger-king.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "7",
      name: "Burger King",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://i.ibb.co/0nQqZ1w/burger-king.jpg",
      isOpen: true,
    ),
  ];

  Future<List<Outlet>> getOutlets() async {
    await Future.delayed(const Duration(seconds: 4));
    return _outlets;
  }

  Future<List<Outlet>> getOutletsBySearch(String search) async {
    await Future.delayed(const Duration(seconds: 4));
    return _outlets.where((outlet) {
      return outlet.name.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }
}
