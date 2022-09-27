import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget{
  String? labelText;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  BuildContext context;
  TextInputType? keyboardType;
  var suffixIcon;


  BuildTextField({this.labelText, this.validator, this.controller, required this.context, this.keyboardType, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: keyboardType!,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey,
                width: 2.0
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                width: 2.0
            ),
          ),
          labelText: labelText,
          suffixIcon: suffixIcon != null ? GestureDetector(
            onTap: suffixIcon['onTap'],
            child: Icon(
                suffixIcon['icon']
            ),
          ) : const SizedBox()
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }
}