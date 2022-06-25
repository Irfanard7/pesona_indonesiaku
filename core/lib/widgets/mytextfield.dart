import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField(
    TextEditingController controller, String labelText, String hintText, TextInputType inputType) {
  return Container(
    child: TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.black, fontSize: 17),
      validator: (value) {
        if (value!.isEmpty) {
          return "it is empty";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 17),
          labelStyle: const TextStyle(color: Colors.grey),
          // prefix: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    ),
  );
}
