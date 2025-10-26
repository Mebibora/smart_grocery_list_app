import 'package:flutter/material.dart';
import 'globals.dart'; // <-- add this import for animation toggle access

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Grocery App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // View List button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('View List'),
            ),

            const SizedBox(height: 20),

            // Weekly List Generator button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              child: const Text('Weekly List Generator'),
            ),

            const SizedBox(height: 20),

            // New Accessibility Button — Disable Animations
            ElevatedButton.icon(
              icon: Icon(animationsEnabled ? Icons.visibility : Icons.visibility_off),
              label: Text(
                animationsEnabled ? "Turn Off Animations" : "Turn On Animations",
              ),
              onPressed: () {
                setState(() {
                  animationsEnabled = !animationsEnabled;
                });
                final snackBar = SnackBar(
                  content: Text(
                    animationsEnabled
                        ? "Animations Enabled"
                        : "Animations Disabled (Accessibility Mode)",
                  ),
                  duration: const Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),

            const Spacer(),

            //Theme toggle button (unchanged)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: widget.onToggleTheme,
                    child: const Text('Toggle Theme'),
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
