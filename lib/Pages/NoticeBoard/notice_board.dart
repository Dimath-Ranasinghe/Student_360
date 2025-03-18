import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student360/Components/student_nav_bar.dart';

import '../../API/base.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {

  List<Map<String, dynamic>> notices = [];

  @override
  void initState() {
    _getNotices();
  }

  void _getNotices() async {
    debugPrint("Getting notice");
    http.Response response = await getNotices();

    if (response.statusCode == 200) {
      debugPrint("User data received ${response.body}");

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("data")) {
        List<dynamic> noticesData = jsonResponse["data"];

        setState(() {
          notices = noticesData.map((e) => {
            "title": e["title"] ?? "",
            "content": e["content"] ?? "",
            "date": e["date"]?.toString().split("T")[0] ?? "",  // Format date
          }).toList();
        });
      }
    } else {
      debugPrint("Failed to fetch notices: ${response.statusCode}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 105, 215, 1),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Notice Board",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: notices.isEmpty
          ? const Center(
        child: Text(
          "No Notices Available",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: notices.length,
          itemBuilder: (context, index) {
            final notice = notices[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice['title']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notice['content']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Posted on: ${notice['date']}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
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
