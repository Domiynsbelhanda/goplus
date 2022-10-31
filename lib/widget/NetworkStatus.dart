import 'package:flutter/material.dart';

class InternetNotAvailable extends StatelessWidget {
  const InternetNotAvailable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child:const Center(
        child:  Text(
          'Pas de connexion internet!!!',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}