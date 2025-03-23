import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student360/Components/student_nav_bar.dart';
import 'package:student360/Components/teacher_nav_bar.dart';

import '../../API/basedata.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginHandle() async {
    String userID = _userIDController.text.trim();
    String password = _passwordController.text.trim();

    if (userID.isEmpty || password.isEmpty) {
      _showSnackbar("Please enter both User ID and Password", Colors.orange);
      _userIDController.clear();
      _passwordController.clear();
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(Base.loginURL),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({"userID": userID, "password": password}),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['role'] == 'student') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StudentNavBar()));
          _userIDController.clear();
          _passwordController.clear();
        } else if (data['role'] == 'teacher') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TeacherNavBar()));
          _userIDController.clear();
          _passwordController.clear();
        }
      } else {
        _showSnackbar(data['message'], Colors.red);
        _userIDController.clear();
        _passwordController.clear();
      }
    } catch (e) {
      _showSnackbar("Error connecting to server", Colors.red);
      _userIDController.clear();
      _passwordController.clear();
    }
  }


  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 105, 215, 1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 200,
                      ),
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // User ID Field
                  TextField(
                    controller: _userIDController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withAlpha(95),
                      hintText: 'User ID',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withAlpha(95),
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      suffixIcon: const Icon(Icons.visibility_off, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: loginHandle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Color.fromRGBO(27, 105, 215, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Forget Password
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
