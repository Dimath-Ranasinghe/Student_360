import 'package:flutter/material.dart';
import 'settings_screen.dart'; // Import the settings page

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E), // Dark background color
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 105, 215, 1),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white), 
          onPressed: () {}, // Handle menu button press
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Container(
              width: 130,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 700,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9), // Light gray profile card
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Row containing Profile text & Settings icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PROFILE",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Centered Profile Image
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.black),
                ),
              ),
              SizedBox(height: 16),
              ProfileDetail(title: "Name", value: "Sasan Weerasinghe"),
              ProfileDetail(title: "Contact number 1", value: "072 1234 567"),
              ProfileDetail(title: "Contact number 2", value: "074 1234 567"),
              ProfileDetail(title: "Email Address", value: "sasa@mail.com"),
              ProfileDetail(title: "Class", value: "5-C"),
              ProfileDetail(title: "Date of birth", value: "2015-02-20"),
              ProfileDetail(title: "Class teacher", value: "Mr. Sumith"),
              ProfileDetail(title: "Blood type", value: "O+"),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for displaying profile details
class ProfileDetail extends StatelessWidget {
  final String title;
  final String value;

  ProfileDetail({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
