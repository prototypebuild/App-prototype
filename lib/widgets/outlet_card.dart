import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lefoode/models/outlet.dart';
import 'package:lefoode/screens/subscreens/home/outlet_open.dart';
import 'package:lefoode/widgets/primary_button.dart';
import 'package:lefoode/widgets/v_space.dart';

class OutletCard extends StatelessWidget {
  final Outlet outlet;
  const OutletCard({
    super.key,
    required this.outlet,
  });

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    return OpenContainer(
      closedElevation: 0,
      closedColor: Colors.transparent,
      tappable: false,
      closedBuilder: ((context, action) {
        return Container(
          width: viewport.width,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                  outlet.bannerUrl,
                  height: 190,
                  width: viewport.width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(),
                    Text(
                      outlet.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    VSpace(s: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Ionicons.location, size: 20),
                            Text(outlet.location),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.amber,
                            ),
                            Text(outlet.rating.toString()),
                          ],
                        ),
                      ],
                    ),
                    Chip(
                      label: Text(
                        outlet.isOpen ? "Open" : "Closed",
                      ),
                      backgroundColor: Color(0xff7BFF7B),
                    ),
                    VSpace(s: 5),
                    Container(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: "View Catalogue",
                          filled: true,
                          onTap: action,
                        )),
                    VSpace(s: 5),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      openBuilder: (context, action) {
        return OutletOpenScreen(outlet: outlet);
      },
    );
  }
}
