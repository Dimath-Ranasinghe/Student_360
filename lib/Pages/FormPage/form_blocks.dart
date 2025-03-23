import 'package:flutter/material.dart';

class FormBlocks extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const FormBlocks({
    super.key,
    required this.labelText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: textEditingController,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 15, // Reduced font size slightly
            ),
            floatingLabelStyle: const TextStyle(
              color: Color.fromRGBO(27, 105, 215, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), // Reduced padding
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.2, // Slightly thinner border
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(27, 105, 215, 1),
                width: 1.8,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
        ),
      ),
    );
  }
}
