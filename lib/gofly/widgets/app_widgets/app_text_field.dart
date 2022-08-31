import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextFormField? field;
  final String? error;
  const AppTextField({Key? key, this.field, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: field,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              '$error',
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
