import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class TeacherSettingsScreen extends StatefulWidget {
  @override
  _TeacherSettingsScreenState createState() => _TeacherSettingsScreenState();
}

class _TeacherSettingsScreenState extends State<TeacherSettingsScreen> {
  File? _image;
  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController(text: "Mr. John Doe");
  TextEditingController contactController = TextEditingController(text: "071 2345 678");
  TextEditingController emailController = TextEditingController(text: "john.doe@mail.com");
  TextEditingController subjectController = TextEditingController(text: "Mathematics");
  TextEditingController experienceController = TextEditingController(text: "10 Years");
  TextEditingController departmentController = TextEditingController(text: "Science");
  TextEditingController bloodTypeController = TextEditingController(text: "B+");

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
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1869D4),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: 300,
              height: 700,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9), 
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
                      onTap: pickImage, 
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
                    ProfileEditField(label: "Contact Number", controller: contactController),
                    ProfileEditField(label: "Email Address", controller: emailController),
                    ProfileEditField(label: "Subject", controller: subjectController),
                    ProfileEditField(label: "Years of Experience", controller: experienceController),
                    ProfileEditField(label: "Department", controller: departmentController),
                    ProfileEditField(label: "Blood Type", controller: bloodTypeController),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); 
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
