import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lefoode/widgets/primary_button.dart';
import 'package:lefoode/widgets/v_space.dart';

class OutletCard extends StatelessWidget {
  const OutletCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    return Container(
      width: viewport.width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: Color(0xffd3d3d3),
        ),
      ),
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
              "https://content.jdmagicbox.com/comp/ernakulam/d3/0484px484.x484.180913033229.r4d3/catalogue/matha-hotel-palarivattom-ernakulam-restaurants-s6uuek4kb9.jpg",
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
                  "Hotel Matha",
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
                        Text("Edappally"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 20,
                          color: Colors.amber,
                        ),
                        Text("4"),
                      ],
                    ),
                  ],
                ),
                Chip(
                  label: Text(
                    "open",
                  ),
                  backgroundColor: Color(0xff7BFF7B),
                ),
                VSpace(s: 5),
                Container(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: "View Catalogue",
                      filled: true,
                    )),
                VSpace(s: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
