import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/widgets/heading_text.dart';
import 'package:lefoode/widgets/primary_button.dart';
import 'package:lefoode/widgets/touchable_opacity.dart';
import 'package:lefoode/widgets/v_space.dart';

class ChooseFiltersScreen extends StatefulWidget {
  static const routeName = '/home/choose-filters';
  const ChooseFiltersScreen({super.key});

  @override
  State<ChooseFiltersScreen> createState() => _ChooseFiltersScreenState();
}

class _ChooseFiltersScreenState extends State<ChooseFiltersScreen> {
  int cartSize = 0;
  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Filters"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          HeadingText(text: "Order Type"),
          VSpace(s: 5),
          Row(
            children: [
              Container(
                width: viewport.width / 2 - 16,
                height: 50,
                color: ConstantColors.midGrayText,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Delivery"),
                    VSpace(isHorizontal: true),
                    Icon(Icons.directions_bike_outlined, size: 20),
                  ],
                ),
              ),
              Container(
                width: viewport.width / 2 - 16,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ConstantColors.midGrayText,
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pickup"),
                    VSpace(isHorizontal: true),
                    Icon(Ionicons.fast_food_outline, size: 20),
                  ],
                ),
              ),
            ],
          ),
          VSpace(),
          HeadingText(text: "Cart Size"),
          VSpace(s: 5),
          DropdownButton<int>(
            underline: Container(),
            isExpanded: true,
            value: cartSize,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: [0, 500, 1000, 1500, 2000].map((int items) {
              return DropdownMenuItem(
                value: items,
                child: Text("\u{20B9}$items - \u{20B9}${items + 500}"),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                cartSize = newValue!;
              });
            },
          ),
          VSpace(),
          HeadingText(text: "Rating"),
          VSpace(s: 5),
          Row(
            children: [
              for (var i = 0; i < 5; i++)
                Icon(
                  Icons.star,
                  color: i < 2
                      ? ConstantColors.primary
                      : ConstantColors.midGrayText,
                  size: 20,
                ),
            ],
          ),
          VSpace(),
          HeadingText(text: "Preffered Services"),
          VSpace(s: 5),
          Wrap(
            children: [
              for (var service in ["Swiggy", "Zomato", "Uber Eats", "dotPe"])
                TouchableOpacity(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 8, bottom: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ConstantColors.midGrayText,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(service),
                  ),
                ),
            ],
          ),
          VSpace(s: 200),
          PrimaryButton(
            label: "Apply",
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).cardColor,
                  content: Text(
                    "Filters Applied",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
