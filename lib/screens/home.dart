import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lefoode/api/fake_api.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/models/outlet.dart';
import 'package:lefoode/screens/settings.dart';
import 'package:lefoode/screens/subscreens/home/choose_filters.dart';
import 'package:lefoode/widgets/fade_animation.dart';
import 'package:lefoode/widgets/input.dart';
import 'package:lefoode/widgets/location_handler.dart';
import 'package:lefoode/widgets/outlet_card.dart';
import 'package:lefoode/widgets/touchable_opacity.dart';
import 'package:lottie/lottie.dart';

import '../widgets/v_space.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loaded = false;
  List<Outlet> _loadedOutlets = [];
  @override
  void initState() {
    getDefaultOutlets();
    super.initState();
  }

  void getDefaultOutlets() {
    setState(() {
      loaded = false;
    });
    _loadedOutlets.clear();
    FakeApiManager().getOutlets().then((value) {
      setState(() {
        _loadedOutlets = value;
        loaded = true;
      });
    });
  }

  void searchOutletsByName(String query) {
    setState(() {
      loaded = false;
    });
    _loadedOutlets.clear();
    FakeApiManager().getOutletsBySearch(query).then((value) {
      setState(() {
        _loadedOutlets = value;
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Le Foode"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
              icon: Icon(Ionicons.settings_outline)),
        ],
      ),
      body: LocationBasedWidget(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Center(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      searchOutletsByName(value.trim());
                    } else {
                      getDefaultOutlets();
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Ionicons.search_outline,
                      color: ConstantColors.primary,
                    ),
                    suffixIcon: TouchableOpacity(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ChooseFiltersScreen.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12.0),
                        child: Icon(
                          Ionicons.filter_outline,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                    hintText: "Search Restaurants around you",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Restaurants near you",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: ConstantColors.midGrayText,
                ),
              ),
            ),
            VSpace(s: 10),
            if (!loaded)
             for(var j = 0;j<5;j++)
             OutletCard.loading(context)
            else
              Column(
                children: [
                  for (var i = 0; i < _loadedOutlets.length; i++)
                    Column(
                      children: [
                        FadeAnimation(
                          child: OutletCard(
                            outlet: _loadedOutlets[i],
                          ),
                          delay: i + 1,
                        ),
                        if (i != _loadedOutlets.length - 1) VSpace(s: 10),
                      ],
                    ),
                  if (_loadedOutlets.isEmpty) ...[
                    Lottie.asset("assets/anim/data-not-found.json",
                        height: 400, width: 400),
                    VSpace(),
                    Text(
                      "Try searching for something else",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
