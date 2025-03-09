import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student360/TeacherNoticeBoard/teacher_notice.dart';
import 'package:http/http.dart' as http;

import '../API/base.dart';


class TeacherNoticePage extends StatefulWidget {
  const TeacherNoticePage({super.key});

  @override
  State<TeacherNoticePage> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<TeacherNoticePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _getNotices();
  }

  void _getNotices() async{
    debugPrint("Fetching Notices...");
    http.Response response = await getNotices();

    if (response.statusCode == 200 || response.statusCode ==201){
      debugPrint("Notices Recieved");
      List<dynamic> jsonResponse = jsonDecode(response.body);

      setState(() {
        TeacherNote.noticeList =
            jsonResponse.map((e) => TeacherNote.fromJson(e)).toList();
      });
    } else {
      debugPrint("Failed to fetach notices");
    }
  }

  void addNewNotice() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.white,
        title: Center(
          child: Text("ADD NEW NOTICE",
            style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(27, 105, 215, 1)),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 0, left: 0, right: 0),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: Column(
              children: [
                SizedBox(height: 15),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: "Notice Title",
                      labelStyle: TextStyle(color: Colors.black),
                      floatingLabelStyle: TextStyle(color: Color.fromRGBO(27, 105, 215, 1)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color.fromRGBO(27, 105, 215, 1), width: 1.5),
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromRGBO(27, 105, 215, 1),width: 1.7),
                    )
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: contentController,
                  maxLines: 8,
                  decoration: InputDecoration(
                      hintText: "Notice Content",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color.fromRGBO(27, 105, 215, 1), width: 1.5)
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromRGBO(27, 105, 215, 1),width: 1.7)
                    )
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed:() => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(27, 105, 215, 1), // Custom button color
                        foregroundColor: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      child: Text("Cancel"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: saveNewNotice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(27, 105, 215, 1), // Custom button color
                        foregroundColor: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      child: Text("Add"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void saveNewNotice() async{
    if(titleController.text.isNotEmpty && contentController.text.isNotEmpty){
      bool isSuccess = await postNotice(titleController.text, contentController.text);
      if(isSuccess){
        _getNotices();
        titleController.clear();
        contentController.clear();
        Navigator.pop(context);
      }else{
        _showErrorDialog("Failed to add notice. Please try again.");
      }
    }else{
      _showErrorDialog("Title and content cannot be empty.");
    }
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
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
      body: TeacherNote.noticeList.isEmpty
          ? const Center(
        child: Text(
          "No Notices Available",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: TeacherNote.noticeList.length,
          itemBuilder: (context, index) {
            final reversedList = TeacherNote.noticeList.reversed.toList();
            final notice = reversedList[index];
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
                      notice.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notice.content,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Posted on: ${notice.dateTime.toString()}",
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addNewNotice();
        },
        backgroundColor: Color.fromRGBO(27, 105, 215, 1),
        child: Icon(Icons.add,size: 30,),
      ),
    );
  }
}
