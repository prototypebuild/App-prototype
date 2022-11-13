import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/firebase_options.dart';
import 'package:lefoode/screens/auth/launch_decider.dart';
import 'package:lefoode/screens/auth/phone_auth.dart';
import 'package:lefoode/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lefoode/screens/subscreens/home/choose_filters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeFoode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ConstantColors.primary,
        primarySwatch: Colors.red,
        cardTheme: const CardTheme(
          // color: Color.fromRGBO(35, 37, 47, 1),
          color: Color(0xff2C2C30),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.light().textTheme.copyWith(),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: ConstantColors.primary,
        cardTheme: const CardTheme(
          // color: Color.fromRGBO(35, 37, 47, 1),
          color: Color(0xff2C2C30),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme.copyWith(),
        ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: LaunchDecider.routeName,
      routes: {
        LaunchDecider.routeName: (ctx) => const LaunchDecider(),
        PhoneAuthScreen.routeName: (ctx) => const PhoneAuthScreen(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        ChooseFiltersScreen.routeName: (ctx) => const ChooseFiltersScreen(),
      },
    );
  }
}
