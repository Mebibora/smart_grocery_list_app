// Screen Two
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/grocery_item.dart';


class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your List')),
      body: Center(
        // Button for returning back to the home screen
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
