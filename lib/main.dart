import 'package:flutter/material.dart';
import 'teacher_profile.dart'; // Import the profile screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teacher Profile',
      theme: ThemeData(
        primaryColor: Color(0xFF1869D4), // Blue header color
      ),
      home: TeacherProfileScreen(), // Set profile screen as the home screen
    );
  }
}
