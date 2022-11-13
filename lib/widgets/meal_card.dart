import 'package:flutter/material.dart';
import 'package:lefoode/models/meal.dart';
import 'package:lefoode/widgets/touchable_opacity.dart';
import 'package:lefoode/widgets/v_space.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    var leastDealPrice = meal.deals.values.toList().reduce((value, element) {
      if (value < element) {
        return value;
      } else {
        return element;
      }
    });
    return TouchableOpacity(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            builder: (context) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "Price Comparison",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Divider(indent: 16, endIndent: 16),
                    for (var deal in meal.deals.keys)
                      ListTile(
                        title: Text(deal[0].toUpperCase() + deal.substring(1)),
                        // rupee symbol
                        subtitle: Text("\u20B9 ${meal.deals[deal]}"),
                        trailing: meal.deals[deal] == leastDealPrice
                            ? Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              )
                            : null,
                      ),
                  ],
                ),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 115,
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                "https://static.toiimg.com/photo/msid-87930581/87930581.jpg?211826",
                fit: BoxFit.cover,
              ),
            ),
            VSpace(isHorizontal: true),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VSpace(),
                Text(
                  meal.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                VSpace(s: 5),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Text(meal.rating.toString()),
                    VSpace(isHorizontal: true),
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                VSpace(),
                Text(
                  "Best deal",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.green,
                  ),
                ),
                Text(
                  "₹ $leastDealPrice",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget loading() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 115,
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Shimmer(child: Container())),
          VSpace(isHorizontal: true),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(),
              Container(
                  width: 100, height: 20, child: Shimmer(child: Container())),
              VSpace(s: 5),
              Row(
                children: [
                  Container(
                      width: 100,
                      height: 20,
                      child: Shimmer(child: Container())),
                  VSpace(isHorizontal: true),
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              VSpace(),
              Container(
                  width: 100, height: 20, child: Shimmer(child: Container())),
            ],
          ),
        ],
      ),
    );
  }
}
