import 'package:flutter/material.dart';
import 'package:texi_booking/widgets/map_widget.dart';
import 'package:provider/provider.dart';
import 'package:texi_booking/models/locales_models.dart';
import 'package:texi_booking/models/locales_provider_model.dart';

class TrackYourRidesScreen extends StatefulWidget {
  @override
  _TrackYourRidesScreenState createState() => _TrackYourRidesScreenState();
}

class _TrackYourRidesScreenState extends State<TrackYourRidesScreen> {
  Size size;

  CancelRideModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .cancelRideScreen;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Text(
          _localeText.trackRide,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// [Map]
            MapWidget(),
          ],
        ),
      ),
    );
  }
}
