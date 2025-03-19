import 'package:flutter/material.dart';

class FormBlocks extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const FormBlocks({
    super.key,
    required this.labelText,
    required this.textEditingController
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            floatingLabelStyle: const TextStyle(
              color: Color.fromRGBO(27, 105, 215, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color.fromRGBO(27, 105, 215, 1),
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
