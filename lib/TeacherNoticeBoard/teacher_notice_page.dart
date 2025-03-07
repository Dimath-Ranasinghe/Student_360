import 'package:flutter/material.dart';
import 'package:student360/TeacherNoticeBoard/teacher_notice.dart';

class TeacherNoticePage extends StatefulWidget {
  const TeacherNoticePage({super.key});

  @override
  State<TeacherNoticePage> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<TeacherNoticePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: contentController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: "Notice Content",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
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
            final notice = TeacherNote.noticeList[index];
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
