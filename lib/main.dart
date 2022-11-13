import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/firebase_options.dart';
import 'package:lefoode/providers/theme_provider.dart';
import 'package:lefoode/screens/auth/launch_decider.dart';
import 'package:lefoode/screens/auth/phone_auth.dart';
import 'package:lefoode/screens/auth/register.dart';
import 'package:lefoode/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lefoode/screens/settings.dart';
import 'package:lefoode/screens/subscreens/home/choose_filters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<ThemeProvider>(context, listen: false).loadTheme();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'LeFoode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ConstantColors.primary,
        primarySwatch: Colors.red,
        cardTheme: const CardTheme(
          // color: Color.fromRGBO(35, 37, 47, 1),
          // color: Color(0xff2C2C30),
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
      themeMode: themeProvider.themeMode,
      initialRoute: LaunchDecider.routeName,
      routes: {
        LaunchDecider.routeName: (ctx) => const LaunchDecider(),
        PhoneAuthScreen.routeName: (ctx) => const PhoneAuthScreen(),
        RegistrationScreen.routeName: (ctx) => const RegistrationScreen(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        ChooseFiltersScreen.routeName: (ctx) => const ChooseFiltersScreen(),
        SettingsScreen.routeName: (ctx) => const SettingsScreen(),
      },
    );
  }
}
