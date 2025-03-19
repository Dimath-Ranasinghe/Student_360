import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student360/Components/student_nav_bar.dart';
import 'package:student360/Components/teacher_nav_bar.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginHandle(){
    String userID = _userIDController.text.trim();

    if (userID.length == 6) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StudentNavBar()));
      _userIDController.clear();
    } else if (userID.length == 5) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TeacherNavBar()));
      _userIDController.clear();
    } else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Center(child: Text("Invalid User ID. Please Enter a Valid User ID",)),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
      ));
    }
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
                      suffixIcon: const Icon(Icons.visibility_off,
                          color:Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      loginHandle();
                    },
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
