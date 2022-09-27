import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget{
  String? labelText;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  BuildContext context;
  TextInputType? keyboardType;


  BuildTextField({this.labelText, this.validator, this.controller, required this.context, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: keyboardType!,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey,
                width: 2.0
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                width: 2.0
            ),
          ),
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }
}