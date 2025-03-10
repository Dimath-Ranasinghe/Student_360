import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _image;
  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController(text: "Sasan Weerasinghe");
  TextEditingController contactController = TextEditingController(text: "072 1234 567");
  TextEditingController emailController = TextEditingController(text: "sasa@mail.com");
  TextEditingController classController = TextEditingController(text: "5-C");

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E), // Dark background
      appBar: AppBar(
        backgroundColor: Color(0xFF1869D4), // Blue header
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double size = constraints.maxWidth * 0.8; // Make height = width
            return Container(
              width: size,
              height: size, // Keep it square
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9), // Light gray profile card
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "EDIT PROFILE",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: pickImage, // Open gallery to pick an image
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.camera_alt, size: 40, color: Colors.black)
                            : null,
                      ),
                    ),
                    SizedBox(height: 16),
                    ProfileEditField(label: "Name", controller: nameController),
                    ProfileEditField(label: "Contact number", controller: contactController),
                    ProfileEditField(label: "Email Address", controller: emailController),
                    ProfileEditField(label: "Class", controller: classController),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle profile update logic here
                        Navigator.pop(context); // Go back to profile screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1869D4),
                      ),
                      child: Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Widget for text fields in settings page
class ProfileEditField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  ProfileEditField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
