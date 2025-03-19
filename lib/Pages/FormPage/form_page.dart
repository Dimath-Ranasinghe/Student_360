import 'package:flutter/material.dart';
import 'package:student360/Pages/FormPage/form_blocks.dart';

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
      builder: (_) =>
          ListView(
            shrinkWrap: true,
            children: items.map((item) =>
                ListTile(
                  title: Text(item, style: const TextStyle(
                      fontSize: 17, color: Colors.black)),
                  onTap: () {
                    onSelect(item);
                    Navigator.pop(context);
                  },
                )).toList(),
          ),
    );
  }

  Widget _buildDropdown(String hint, String? value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? hint,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: value == null ? Colors.grey.shade700 : Colors.black),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          ],
        ),
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(25, 0, 0, 0),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Student ID Input
                    TextFormField(
                      controller: _studentIdController,
                      style: const TextStyle(fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: "Student ID",
                        labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold
                        ),
                        floatingLabelStyle: const TextStyle(
                            color: Color.fromRGBO(27, 105, 215, 1)),
                        prefixIcon: Icon(Icons.badge, color: primaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(27, 105, 215, 1),
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty
                          ? 'Enter Student ID'
                          : null,
                    ),
                    const SizedBox(height: 12),


                    _buildDropdown("Select Term", selectedTerm, () =>
                        _showSelectionModal(terms, (val) =>
                            setState(() => selectedTerm = val))),
                    Row(
                      children: [
                        Expanded(child: _buildDropdown("Grade",
                            selectedGrade, () =>
                                _showSelectionModal(grades, (val) =>
                                    setState(() => selectedGrade = val)))),
                        const SizedBox(width: 12),
                        Expanded(child: _buildDropdown("Class",
                            selectedClass, () =>
                                _showSelectionModal(classes, (val) =>
                                    setState(() => selectedClass = val)))),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Subject Fields
                    FormBlocks(
                      labelText: "English",
                      textEditingController: englishController,),
                    FormBlocks(
                      labelText: "Sinhalese",
                      textEditingController: sinhaleseController,),
                    FormBlocks(
                      labelText: "Buddhism",
                      textEditingController: buddhismController,),
                    FormBlocks(
                      labelText: "Mathematics",
                      textEditingController: mathematicsController,),
                    FormBlocks(
                      labelText: "Total Days Held",
                      textEditingController: totalDaysHeldController,),
                    FormBlocks(
                      labelText: "Total Days Attended",
                      textEditingController: totalDaysAttendedController,),

                    const SizedBox(height: 20),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              selectedTerm != null &&
                              selectedGrade != null &&
                              selectedClass != null) {
                            // Submit action
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Center(child: Text(
                                  "Please Complete all the Fields")),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            )
                            );
                          }
                        },
                        child: const Text("Submit", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
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
