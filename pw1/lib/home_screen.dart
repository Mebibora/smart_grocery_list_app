// lib/screen_one.dart
import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const ScreenOne({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Grocery App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('View List'),
            ),            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              child: const Text('Weekly List Generator'),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0), 
                  child: ElevatedButton(
                    onPressed: onToggleTheme,                    
                    child: Text('Toggle Theme'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
