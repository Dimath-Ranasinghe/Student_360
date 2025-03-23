import 'package:flutter/material.dart';

class RecordBook extends StatefulWidget {
  const RecordBook({super.key});

  @override
  State<RecordBook> createState() => _RecordBookState();
}

class _RecordBookState extends State<RecordBook> {
  List<List<String>> records = [
    ["English", "20", "30", "5"],
    ["Sinhala", "20", "20", "20"],
    ["Buddhism", "20", "20", "20"],
    ["Maths", "20", "20", "20"],
    ["E.Studies", "20", "20", "20"],
    ["Total", "0", "0", "0"],
    ["Average", "20", "20", "20"],
    ["Position", "20", "20", "20"],
    ["TDH", "20", "20", "20"],
    ["TDA", "20", "20", "20"]
  ];

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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 16.0,
                      border: TableBorder.all(color: Colors.black12),
                      headingRowColor: MaterialStateColor.resolveWith(
                              (states) => const Color.fromRGBO(173, 216, 230, 1)), // Light blue header color
                      columns: const [
                        DataColumn(label: Text("Subject", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                        DataColumn(label: Text("1st Term", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                        DataColumn(label: Text("2nd Term", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                        DataColumn(label: Text("3rd Term", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)))
                      ],
                      rows: List.generate(records.length, (index) {
                        // Alternate row color: White first, then light gray
                        Color rowColor = (index % 2 == 0)
                            ? Colors.white // White
                            : const Color.fromRGBO(240, 240, 240, 1); // Light gray

                        return DataRow(
                          color: MaterialStateProperty.all(rowColor),
                          cells: records[index]
                              .map((cell) => DataCell(
                            Text(
                              cell,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center, // Centering the text
                            ),
                          ))
                              .toList(),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "TDH = Total Days Held",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        Text(
                          "TDA = Total Days Attended",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ],
                    ),
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
