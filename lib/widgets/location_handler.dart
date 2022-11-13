import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/widgets/primary_button.dart';
import 'package:lefoode/widgets/v_space.dart';
import 'package:lottie/lottie.dart';

class LocationBasedWidget extends StatefulWidget {
  final Widget child;
  const LocationBasedWidget({super.key, required this.child});

  @override
  State<LocationBasedWidget> createState() => _LocationBasedWidgetState();
}

class _LocationBasedWidgetState extends State<LocationBasedWidget> {
  bool _loaded = false;
  bool _isLocationEnabled = true;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    runLocationCheck();
    super.initState();
  }

  void runLocationCheck() {
    _determinePosition().then((value) {
      setState(() {
        _isLocationEnabled = true;
        _loaded = true;
      });
    }).catchError((e) {
      setState(() {
        _isLocationEnabled = false;
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return Center(
        child: Transform.scale(
          scale: .5,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return _isLocationEnabled
        ? widget.child
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  "assets/anim/location.json",
                  height: 300,
                ),
              ),
              VSpace(s: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Please enable location services to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: ConstantColors.midGrayText,
                  ),
                ),
              ),
              VSpace(s: 20),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: PrimaryButton(
                    label: "Enable Location", onTap: runLocationCheck),
              ),
              VSpace(s: 20),
            ],
          );
  }
}
