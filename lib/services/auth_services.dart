import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:student360/Components/student_nav_bar.dart';
import 'package:student360/Components/teacher_nav_bar.dart';
import '../API/basedata.dart';

class AuthService {
  Future<void> loginHandle(BuildContext context, String userID, String password) async {
    String url = Base.loginURL;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"userID": userID, "password": password}),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Navigate based on role
        if (data['role'] == 'student') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => StudentNavBar()));
        } else if (data['role'] == 'teacher') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TeacherNavBar()));
        }
      } else {
        _showSnackbar(context, data['message']);
      }
    } catch (e) {
      _showSnackbar(context, "Error connecting to server");
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
