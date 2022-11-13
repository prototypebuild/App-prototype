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
      bannerUrl: "https://content.jdmagicbox.com/comp/ernakulam/d3/0484px484.x484.180913033229.r4d3/catalogue/matha-hotel-palarivattom-ernakulam-restaurants-s6uuek4kb9.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "2",
      name: "McDonald's",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://b.zmtcdn.com/data/reviews_photos/fcc/5d65bee06e9c70bfb26bf09e02c0cfcc_1594595835.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "3",
      name: "KFC",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8v2Z-uo67bmbQQypMLi_TX_g5uXGCOzVepJ1T7r_YDaud7E3Kt9hQwjCEOeuJ3s73AnQ&usqp=CAU",
      isOpen: true,
    ),
    Outlet(
      id: "4",
      name: "Subway",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://b.zmtcdn.com/data/reviews_photos/c8d/fd0474f57050abf19b411abc3a2e2c8d_1620716245.jpg?fit=around|771.75:416.25&crop=771.75:416.25;*,*",
      isOpen: true,
    ),
    Outlet(
      id: "5",
      name: "Domino's",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://images.hindustantimes.com/img/2022/02/09/550x309/loving-india-restaurants-problem-mcdonald-legal-pizza_8f254a9c-323e-11e8-a509-12b0194ead35_1644374671583.jpg",
      isOpen: true,
    ),
    Outlet(
      id: "6",
      name: "Pizza Hut",
      location: "Sector 29, Gurgaon",
      rating: 4.0,
      bannerUrl: "https://media-cdn.tripadvisor.com/media/photo-s/0e/86/3f/4b/the-outlet-from-outside.jpg",
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
