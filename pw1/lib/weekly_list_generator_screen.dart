// Screen Three
import 'package:flutter/material.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly List Generator')),
      body: Center(
        // Button for returning to the home screen
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); 
          },
          child: const Text('Back to Home Screen'),
        ),
      ),
    );
  }
}