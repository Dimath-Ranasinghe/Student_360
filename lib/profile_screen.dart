import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xFF1E1E1E), // Dark background color
appBar: AppBar(
backgroundColor: Color(0xFF1869D4), // Blue app bar
title: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [

SizedBox(width: 8),
Text('STUDENT 360°'),
],
),
centerTitle: true,
leading: IconButton(
icon: Icon(Icons.menu, color: Colors.white),
onPressed: () {}, // Handle menu button press
),
),
body: Center(
child: Container(
margin: EdgeInsets.all(16),
padding: EdgeInsets.all(16),
decoration: BoxDecoration(
color: Color(0xFFD9D9D9), // Light gray profile card
borderRadius: BorderRadius.circular(16),
),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Align(
alignment: Alignment.topLeft,
child: Text(
"PROFILE",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
),

SizedBox(height: 16),
ProfileDetail(title: "Name", value: "Sasan Weerasinghe"),
ProfileDetail(title: "Contact number", value: "072 1234 567"),
ProfileDetail(title: "Email Address", value: "sasa@mail.com"),
ProfileDetail(title: "Class", value: "5-C"),
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

