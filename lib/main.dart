import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Import the profile screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      theme: ThemeData(
        primaryColor: Color(0xFF1869D4), // Blue header color
      ),
      home: ProfileScreen(), // Set profile screen as the home screen
    );
  }
}
