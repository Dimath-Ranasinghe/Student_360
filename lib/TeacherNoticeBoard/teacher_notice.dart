import 'package:flutter/material.dart';

class TeacherNote{
  final String title;
  final String content;
  final DateTime dateTime;

  TeacherNote({
    required this.title,
    required this.content,
    required this.dateTime
  });
  factory TeacherNote.fromJson(Map<String, dynamic> json){
    return TeacherNote(
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      dateTime: DateTime.tryParse(json["date"] ?? "") ??
          DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
    };
  }

  static List<TeacherNote> noticeList = [];
}