import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:texi_booking/models/locales_models.dart';
import 'package:texi_booking/models/locales_provider_model.dart';
import 'package:texi_booking/utils/app_colors.dart';
import 'package:texi_booking/utils/strings.dart';
import 'package:texi_booking/widgets/kf_drawer.dart';

import 'notification_screen.dart';

class YourRidesScreen extends KFDrawerContent {
  final bool isPage;
  YourRidesScreen({this.isPage});
  @override
  YourRidesScreenState createState() => YourRidesScreenState();
}

class YourRidesScreenState extends State<YourRidesScreen> {
  Size size;
  List ride = [
    {"day": "Today", "time": "05:30AM"},
    {"day": "Fri,Oct 05", "time": "05:05AM"},
    {"day": "Fri,Oct 03", "time": "03:05AM"},
    {"day": "Mon,Oct 01", "time": "05:30AM"},
  ];
  int selectedRide = 0;

  YourRideModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .yourRideScreen;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: widget.isPage ?? false
              ? () {
                  Navigator.pop(context);
                }
              : widget.onMenuPressed,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          _localeText.yourRides,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          widget.isPage ?? false
              ? GestureDetector(
                  onTap: widget.onMenuPressed,
                  child: Container(
                    height: 35,
                    width: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: SvgPicture.asset("assets/menu.svg"),
                  ),
                )
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: ride
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    Container(
                      height: size.height * 0.27,
                      width: size.width,
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ride[index]["day"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ride[index]["time"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRide = index;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NotificationsScreen(
                                        isPage: true,
                                      ),
                                    ));
                              });
                            },
                            child: Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(blurRadius: 3.0, color: Colors.grey)
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                                color: selectedRide == index
                                    ? Colors.yellow[100]
                                    : Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Toyota Car",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.04,
                                          width: size.width * 0.2,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0))),
                                          child: Text(
                                            "05:30AM",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        Icon(Icons.my_location),
                                        SizedBox(width: 20.0),
                                        Flexible(
                                          child: Text(
                                            "85 W,Jockey street park forest,ILL 60466",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 50.0),
                                    height: size.height * 0.001,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          StringValue.RIGHTARROW,
                                        ),
                                        SizedBox(width: 20.0),
                                        Flexible(
                                            child: Text(
                                          "64 W,Rockland forest,ILL 60466",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14),
                                        ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 50.0),
                                    height: size.height * 0.001,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}
