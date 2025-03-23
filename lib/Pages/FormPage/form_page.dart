import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student360/Pages/FormPage/form_blocks.dart';

import '../../API/basedata.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final TextEditingController englishController = TextEditingController();
  final TextEditingController sinhaleseController = TextEditingController();
  final TextEditingController buddhismController = TextEditingController();
  final TextEditingController mathematicsController = TextEditingController();
  final TextEditingController environmentalStudiesController = TextEditingController();
  final TextEditingController totalDaysHeldController = TextEditingController();
  final TextEditingController totalDaysAttendedController = TextEditingController();

  final Color primaryColor = const Color(0xFF1B69D7);

  String? selectedTerm, selectedGrade, selectedClass;
  final terms = ["1st Term", "2nd Term", "3rd Term"];
  final grades = ["1", "2", "3", "4", "5"];
  final classes = ["A", "B", "C", "D"];

  @override
  void dispose() {
    _studentIdController.dispose();
    super.dispose();
  }

  void _showSelectionModal(List<String> items, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (_) => ListView(
        shrinkWrap: true,
        children: items.map((item) => ListTile(
          title: Text(item, style: const TextStyle(fontSize: 15, color: Colors.black)),
          onTap: () {
            onSelect(item);
            Navigator.pop(context);
          },
        )).toList(),
      ),
    );
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate() || selectedTerm == null || selectedGrade == null || selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Center(child: Text("Please complete all fields")),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final Map<String, dynamic> formData = {
      "studentID": _studentIdController.text,
      "grade": int.tryParse(selectedGrade ?? "0") ?? 0,
      "class": selectedClass,
      "term": selectedTerm,
      "subjects": [
        {"subjectName": "English", "marks": double.tryParse(englishController.text) ?? 0},
        {"subjectName": "Sinhalese", "marks": double.tryParse(sinhaleseController.text) ?? 0},
        {"subjectName": "Buddhism", "marks": double.tryParse(buddhismController.text) ?? 0},
        {"subjectName": "Mathematics", "marks": double.tryParse(mathematicsController.text) ?? 0},
        {"subjectName": "Environmental Studies", "marks": double.tryParse(environmentalStudiesController.text) ?? 0},
      ],
      "totalDaysHeld": int.tryParse(totalDaysHeldController.text) ?? 0,
      "totalDaysAttended": int.tryParse(totalDaysAttendedController.text) ?? 0
    };

    try {
      final response = await http.post(
        Uri.parse(Base.submitMarks),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: const Center(child: Text("Marks updated successfully!")),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      } else {
        throw Exception("Failed to update marks: ${response.body}");
      }
    } catch (error) {
      print("Error submitting form: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Center(child: Text("Error: $error")),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }




  Widget _buildDropdown(String hint, String? value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? hint,
              style: TextStyle(
                  fontSize: 15,
                  color: value == null ? Colors.grey.shade700 : Colors.black),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black, size: 20),
          ],
        ),
      ),
    );
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
          "Form Page",
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _studentIdController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "Student ID",
                        labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                        floatingLabelStyle: const TextStyle(color: Color.fromRGBO(27, 105, 215, 1)),
                        prefixIcon: Icon(Icons.badge, color: primaryColor, size: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color.fromRGBO(27, 105, 215, 1), width: 1.5),
                        ),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter Student ID' : null,
                    ),
                    const SizedBox(height: 8),

                    _buildDropdown("Select Term", selectedTerm, () =>
                        _showSelectionModal(terms, (val) => setState(() => selectedTerm = val))),
                    Row(
                      children: [
                        Expanded(child: _buildDropdown("Grade", selectedGrade, () =>
                            _showSelectionModal(grades, (val) => setState(() => selectedGrade = val)))),
                        const SizedBox(width: 8),
                        Expanded(child: _buildDropdown("Class", selectedClass, () =>
                            _showSelectionModal(classes, (val) => setState(() => selectedClass = val)))),
                      ],
                    ),

                    const SizedBox(height: 8),

                    FormBlocks(labelText: "English", textEditingController: englishController),
                    FormBlocks(labelText: "Sinhalese", textEditingController: sinhaleseController),
                    FormBlocks(labelText: "Buddhism", textEditingController: buddhismController),
                    FormBlocks(labelText: "Mathematics", textEditingController: mathematicsController),
                    FormBlocks(labelText: "Environment Studies", textEditingController: environmentalStudiesController),
                    FormBlocks(labelText: "Total Days Held", textEditingController: totalDaysHeldController),
                    FormBlocks(labelText: "Total Days Attended", textEditingController: totalDaysAttendedController),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                        ),
                        onPressed: () {
                          submitForm();
                        },
                        child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
