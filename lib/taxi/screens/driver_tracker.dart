import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goplus/taxi/pages/driverTrackingPage.dart';

class DriverTracker extends StatefulWidget{
  @override
  State<DriverTracker> createState() => _DriverTracker();
}

class _DriverTracker extends State<DriverTracker>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Ugh oh! Something went wrong");

          if (!snapshot.hasData) return Text("Got no data :(");

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done)
            return DriverTrackingPage();

          return Text("Loading please...");
        },
      ),
    );
  }
}