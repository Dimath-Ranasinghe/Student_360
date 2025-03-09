import 'package:flutter/material.dart';

class TeacherNote {
  final String title;
  final String content;
  final DateTime dateTime;

  TeacherNote({
    required this.title,
    required this.content,
    required this.dateTime,
  });

  // Convert JSON response into a `TeacherNote` object
  factory TeacherNote.fromJson(Map<String, dynamic> json) {
    return TeacherNote(
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      dateTime: DateTime.tryParse(json["date"] ?? "") ??
          DateTime.now(), // Use backend-generated date
    );
  }

  // Convert `TeacherNote` object to JSON (For posting new notices)
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
    };
  }

  // This will hold the notices
  static List<TeacherNote> noticeList = [];
}
