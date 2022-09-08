import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatefulWidget{

  PlaceDetailScreen(this.place);

  final place;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlaceDetailScreen();
  }
}

class _PlaceDetailScreen extends State<PlaceDetailScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text('${this.widget.place['title']}'),
    );
  }
}