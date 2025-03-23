import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student360/Pages/FormPage/form_page.dart';
import 'package:student360/Pages/ProfilePage/teacher_profile.dart';

import '../Pages/Feedbacks/feedback_page.dart';
import '../Pages/RecordBook//record_book.dart';
import '../Pages/NoticeBoard/notice_board.dart';
import '../Pages/TeacherNoticePage/teacher_notice_page.dart';

class TeacherNavBar extends StatefulWidget {
  const TeacherNavBar({super.key});

  @override
  State<TeacherNavBar> createState() => _TeacherNavBarState();
}

class _TeacherNavBarState extends State<TeacherNavBar> {
  int _selectedIndex =0;

  final List<Widget> _pages = [
    FormPage(),
    TeacherNoticePage(),
    FeedbackScreen(),
    TeacherProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(27, 105, 215, 1),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromRGBO(27, 105, 215, 1),
            )
          ],
        ),
        child: GNav(
          gap: 8,
          backgroundColor: Color.fromRGBO(27, 105, 215, 1),
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.black.withOpacity(0.2),
          padding: EdgeInsets.all(16),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            GButton(icon: Icons.assignment_outlined, text: 'RecordBook'),
            GButton(icon: Icons.notifications_outlined, text: 'Notices'),
            GButton(icon: Icons.feedback_outlined, text: 'Feedback'),
            GButton(icon: Icons.person_outline, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}

