import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student360/API/base.dart';


class RecordBook extends StatefulWidget {
  final String userID;

  const RecordBook({
    super.key,
    required this.userID,
  });

  @override
  State<RecordBook> createState() => _RecordBookState();
}

class _RecordBookState extends State<RecordBook> {
  //InitState
  @override
  void initState() {
    super.initState();
    _getStudentMarks(widget.userID);
  }

  List<List<String>> records = [];

  void _getStudentMarks(String studentID) async {
    debugPrint("Getting student marks for ID: $studentID");
    http.Response response = await getStudentMarks(studentID);

    if (response.statusCode == 200) {
      debugPrint("Student marks data received ${response.body}");

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("terms")) {
        List<dynamic> terms = jsonResponse["terms"];

        setState(() {
          Map<String, Map<String, List<String>>> subjectMarks = {};

          for (int termIndex = 0; termIndex < terms.length; termIndex++) {
            var term = terms[termIndex];
            List<dynamic> subjects = term["subjects"] ?? [];

            for (var subject in subjects) {
              String subjectName = subject["subjectName"]?.toString() ?? "";
              String marks = subject["marks"]?.toString() ?? "0";

              // Initialize subject entry if not already present
              subjectMarks.putIfAbsent(
                  subjectName,
                      () => {
                    "marks": ["0", "0", "0"]
                  });

              // Update marks for the current term
              subjectMarks[subjectName]!["marks"]![termIndex] = marks;
            }
          }

          // Convert subjectMarks to records
          records = subjectMarks.entries.map((entry) {
            return [
              entry.key,
              ...entry.value["marks"]!,
            ];
          }).toList();

          debugPrint("Records: $records");

          //total
          int total1stTerm = 0;
          int total2ndTerm = 0;
          int total3rdTerm = 0;

          for (var record in records) {
            total1stTerm += int.tryParse(record[1]) ?? 0;
            total2ndTerm += int.tryParse(record[2]) ?? 0;
            total3rdTerm += int.tryParse(record[3]) ?? 0;
          }

          // average
          int subjectCount = records.length;
          double average1stTerm = total1stTerm / subjectCount;
          double average2ndTerm = total2ndTerm / subjectCount;
          double average3rdTerm = total3rdTerm / subjectCount;

          //TDH TDA
          int tdh1stTerm = total1stTerm > 0 ? 8 : 0;
          int tdh2ndTerm = total2ndTerm > 0 ? 8 : 0;
          int tdh3rdTerm = total3rdTerm > 0 ? 8 : 0;
          int tda1stTerm = total1stTerm > 0 ? 8 : 0;
          int tda2ndTerm = total2ndTerm > 0 ? 8 : 0;
          int tda3rdTerm = total3rdTerm > 0 ? 8 : 0;

          // Add calculated rows to records
          records.add([
            "Total",
            total1stTerm.toString(),
            total2ndTerm.toString(),
            total3rdTerm.toString(),
          ]);
          records.add([
            "Average",
            average1stTerm.toStringAsFixed(2),
            average2ndTerm.toStringAsFixed(2),
            average3rdTerm.toStringAsFixed(2),
          ]);
          records.add([
            "TDH",
            tdh1stTerm.toString(),
            tdh2ndTerm.toString(),
            tdh3rdTerm.toString(),
          ]);
          records.add([
            "TDA",
            tda1stTerm.toString(),
            tda2ndTerm.toString(),
            tda3rdTerm.toString(),
          ]);

          debugPrint("Updated Records: $records");
        });
      }
    } else {
      debugPrint("Failed to fetch student marks: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 105, 215, 1),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Record Book",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              width: 110,
              height: 110,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Table
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 24.0,
                      dataRowMinHeight: 48,
                      headingRowHeight: 48,
                      border: TableBorder.all(color: Colors.black12),
                      headingRowColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromRGBO(173, 216, 230, 1),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            "Subject",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "1st Term",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "2nd Term",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "3rd Term",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: List.generate(records.length, (index) {
                        Color rowColor = index % 2 == 0
                            ? Colors.white
                            : const Color.fromRGBO(240, 240, 240, 1);

                        return DataRow(
                          color: WidgetStateProperty.all(rowColor),
                          cells: records[index].map((cell) {
                            return DataCell(
                              Center(
                                child: Text(
                                  cell == "Environmental Studies" ? "E.Studies" : cell,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Column(
                    children: [
                      Text(
                        "TDH = Total Days Held",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "TDA = Total Days Attended",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
