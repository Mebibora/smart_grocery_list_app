import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

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
      home: HomeScreen(toggleTheme: _toggleTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  HomeScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Grocery App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Spacer(),

            ElevatedButton(
              onPressed: toggleTheme, 
              child: Text('View List')
            ),

            SizedBox(
              height: 10,
            ),
            
            ElevatedButton(
              onPressed: toggleTheme, 
              child: Text('Weekly List Generator')
            ),

            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0), 
                  child: ElevatedButton(
                    onPressed: toggleTheme,                    
                    child: Text('Toggle Theme'),
                  ),
                ),
              ],
            ),
          ]
        ),
      )
    );
  }
}