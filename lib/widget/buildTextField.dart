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
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }
}