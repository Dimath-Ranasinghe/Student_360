import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student360/Pages/RecordBook/record_book.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecordBook(),
    );
  }
}
