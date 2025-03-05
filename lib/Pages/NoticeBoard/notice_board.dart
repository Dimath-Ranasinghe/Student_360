import 'package:flutter/material.dart';


class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  // 🔹 Dummy Notices List
  final List<Map<String, String>> notices = [
    {
      "title": "Exam Schedule Released",
      "description": "The semester exams will start from March 10. Check your schedule.",
      "date": "2025-02-05"
    },
    {
      "title": "Holiday Notice",
      "description": "School will remain closed on February 15 due to maintenance.",
      "date": "2025-02-01"
    },
    {
      "title": "New Library Books Available",
      "description": "New books have been added to the library. Visit and explore!",
      "date": "2025-01-28"
    },
    {
      "title": "Exam Schedule Released",
      "description": "The semester exams will start from March 10. Check your schedule.",
      "date": "2025-02-05"
    },
    {
      "title": "Holiday Notice",
      "description": "School will remain closed on February 15 due to maintenance.",
      "date": "2025-02-01"
    },
    {
      "title": "New Library Books Available",
      "description": "New books have been added to the library. Visit and explore!",
      "date": "2025-01-28"
    },
  ];

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
            padding: const EdgeInsets.only(right: 0.0), // Adjust padding
            child: Container(
              width: 130, // Set width
              height: 100, // Set height
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'), // Image path
                  fit: BoxFit.cover, // Adjust how the image fits
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
                      notice['description']!,
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
