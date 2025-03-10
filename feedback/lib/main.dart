import 'package:flutter/material.dart';
import 'feedback_screen.dart'; // This file will be created next

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // HomeScreen to navigate to FeedbackScreen
      routes: {
        '/feedback': (context) => const FeedbackScreen(),
      },
    );
  }
}

// Basic HomeScreen widget with a navigation button.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open Feedback'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedbackScreen()),
            );
          },
        ),
      ),
    );
  }
}
