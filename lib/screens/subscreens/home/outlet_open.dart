import 'package:flutter/material.dart';
import 'package:lefoode/api/fake_api.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/models/meal.dart';
import 'package:lefoode/models/outlet.dart';
import 'package:lefoode/widgets/fade_animation.dart';
import 'package:lefoode/widgets/meal_card.dart';
import 'package:lefoode/widgets/v_space.dart';

class OutletOpenScreen extends StatefulWidget {
  final Outlet outlet;
  const OutletOpenScreen({super.key, required this.outlet});

  @override
  State<OutletOpenScreen> createState() => _OutletOpenScreenState();
}

class _OutletOpenScreenState extends State<OutletOpenScreen> {
  List<Meal> _loadedMeals = [];
  bool _loaded = false;

  @override
  void initState() {
    loadMeals();
    super.initState();
  }

  void loadMeals() {
    FakeApiManager().getMeals().then((value) {
      setState(() {
        _loadedMeals = value;
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            actions: [
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: Colors.amber,
                  ),
                  Text(widget.outlet.rating.toString()),
                  VSpace(isHorizontal: true),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.outlet.name, textScaleFactor: 1),
              background: Image.network(
                widget.outlet.bannerUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                VSpace(s: 5),
                ListTile(
                  title: Text(
                    "Menu Items",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  subtitle: Text(
                    "Click to compare",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5,
                    ),
                  ),
                ),
                for (var i = 0; i < _loadedMeals.length; i++)
                  FadeAnimation(
                    delay: i + 1,
                    child: MealCard(
                      meal: _loadedMeals[i],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
