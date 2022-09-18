import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget{
  String? labelText;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  BuildContext context;

  BuildTextField({this.labelText, this.validator, this.controller, required this.context});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }
}