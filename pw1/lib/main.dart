import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'user_list_screen.dart';
import 'weekly_list_generator_screen.dart';

void main() {
  runApp(const SmartGroceryApp());
}

class SmartGroceryApp extends StatefulWidget {
  const SmartGroceryApp({super.key});

  @override
  State<SmartGroceryApp> createState() => _SmartGroceryAppState();
}

class _SmartGroceryAppState extends State<SmartGroceryApp> {
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Grocery App',
      theme: isDarkTheme
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.dark,
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
            ),
      home: HomeScreen(onToggleTheme: toggleTheme),
      routes: {
        '/second': (context) => UserListScreen(),
        '/third': (context) => WeeklyListGeneratorScreen(),
      },
    );
  }
}
