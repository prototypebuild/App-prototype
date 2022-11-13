import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/screens/subscreens/home/choose_filters.dart';
import 'package:lefoode/widgets/fade_animation.dart';
import 'package:lefoode/widgets/input.dart';
import 'package:lefoode/widgets/outlet_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loaded = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {
        loaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Le Foode"),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Ionicons.location_outline)),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Center(
              child: TextField(
                onSubmitted: (value) {
                  Navigator.of(context).pushNamed(ChooseFiltersScreen.routeName);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Ionicons.search_outline,
                    color: ConstantColors.primary,
                  ),
                  hintText: "Search Restaurant / Food",
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "Restaurants near you",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: ConstantColors.midGrayText,
              ),
            ),
          ),
          if (!loaded)
            Container(
              height: 400,
              child: Center(
                child: Transform.scale(
                  child: CircularProgressIndicator(),
                  scale: .5,
                ),
              ),
            )
          else
            Column(
              children: [
                for (var i = 0; i < 5; i++)
                  FadeAnimation(
                    child: OutletCard(),
                    delay: i + 1,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
