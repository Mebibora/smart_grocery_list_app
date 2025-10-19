import 'package:flutter/material.dart';
import 'home_screen.dart'; // This is Screen One
import 'user_list_screen.dart'; // This is Screen Two
import 'weekly_list_generator_screen.dart'; // This is Screen Three
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  // These are the setting for the light theme and the dark theme
  final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.lightGreen,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color.fromARGB(255, 78, 168, 186),
  );

  final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 40, 48, 104),
  );

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,

      // This is the configuration for navigation between different screens
      initialRoute: '/',
      routes: {
        '/': (context) => ScreenOne(onToggleTheme: _toggleTheme), // Navigation to the Home Screen
        '/second': (context) => const ScreenTwo(), // Navigation to the User List Screen
        '/third': (context) => const ScreenThree() // Naviagtion to the Weekly list Generator Screen
      },
    );
  }
}
