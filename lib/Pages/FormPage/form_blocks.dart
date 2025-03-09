import 'package:flutter/material.dart';

class FormBlocks extends StatelessWidget {
  final String hintText;

  const FormBlocks({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: Colors.black
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: Color.fromRGBO(27, 105, 215, 1),width: 2.0
                  )
              )
          ),
        ),
      );
  }
}
