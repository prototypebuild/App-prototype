import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lefoode/api/ui_overlays.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/providers/theme_provider.dart';
import 'package:lefoode/screens/auth/launch_decider.dart';
import 'package:lefoode/widgets/v_space.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            child: ListTile(title: Text("General")),
          ),
          Consumer<ThemeProvider>(
            builder: ((context, themeProvider, child) {
              return ListTile(
                leading: Icon(Ionicons.contrast_outline),
                title: Text("Dark Mode"),
                subtitle: Text(
                    "Current mode: ${themeProvider.isDarkMode ? "Dark" : "Light"}"),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    themeProvider
                        .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              );
            }),
          ),
          ListTile(
            leading: Icon(Ionicons.power_outline),
            title: Text(
              "Logout",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () async {
              UIOverlays.showLoadingOverlay(context);
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LaunchDecider.routeName, (route) => false);
            },
          ),
          Spacer(),
          Center(
            child: Text(
              "LeFoode - v1.0.0",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: ConstantColors.midGrayText,
              ),
            ),
          ),
          VSpace(s: 50),
        ],
      ),
    );
  }
}
