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

  static List<TeacherNote> noticeList = [
    TeacherNote(
        title: "Exam Schedule Released",
        content: "The semester exams will start from March 10. Check your schedule.",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "Holiday Notice",
        content: "School will remain closed on February 15 due to maintenance.",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "New Library Books Available",
        content: "New books have been added to the library. Visit and explore!",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "Exam Schedule Released",
        content: "The semester exams will start from March 10. Check your schedule.",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "Exam Schedule Released",
        content: "The semester exams will start from March 10. Check your schedule.",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "Holiday Notice",
        content: "School will remain closed on February 15 due to maintenance.",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "New Library Books Available",
        content: "New books have been added to the library. Visit and explore!",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "Exam Schedule Released",
        content: "The semester exams will start from March 10. Check your schedule.",
        dateTime: DateTime.now()
    ),
    TeacherNote(
        title: "Holiday Notice",
        content: "School will remain closed on February 15 due to maintenance.",
        dateTime: DateTime.now()
    )
  ];

}