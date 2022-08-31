import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goplus/gofly/pages/review_screen.dart';
import 'package:goplus/gofly/pages/track_your_ride_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/widgets/map_widget.dart';

class CancelRideScreen extends StatefulWidget {
  @override
  _CancelRideScreenState createState() => _CancelRideScreenState();
}

class _CancelRideScreenState extends State<CancelRideScreen> {
  late Size size;

  late CancelRideModel _localeText;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((_) {
      bottomsheet();
    });
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .cancelRideScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: GestureDetector(
          onTap: bottomsheet,
          child: Container(
            height: size.height * 0.005,
            width: size.width * 0.2,
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// [Map]

            MapWidget(),

            ///[AppBar]

            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: APPBAR(
                menu: true,
                visiable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomsheet() {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: size.height * 0.005,
                  width: size.width * 0.2,
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 15.0, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          height: size.width * 0.15,
                          width: size.width * 0.15,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200], shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Evaana Musk",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "1,925 Trips",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(Icons.call)
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 0.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Container(
                          height: size.width * 0.2,
                          width: size.width * 0.2,
                          child: SvgPicture.asset(
                            StringValue.TOYOTA,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "GJ 05 KL 0007",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Honda Car",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.035,
                          width: size.width * 0.15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              color: AppColors.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5)
                              ]),
                          child: Text(
                            "01 Hour",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            offset: Offset(0, -5),
                            blurRadius: 5,
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _localeText.dropOff,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "4:55PM",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _localeText.distance,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "8 KM",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _localeText.price,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "\$105",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          trackYourRideBtn(),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          cancelRideBtn(context)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        );
      },
    );
  }

  trackYourRideBtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrackYourRidesScreen(),
          ),
        );
      },
      child: Container(
        height: size.height * 0.05,
        width: size.width * 0.8,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(size.height * 0.025),
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.height * 0.025),
          ),
          clipBehavior: Clip.antiAlias,
          child: Center(
            child: Text(
              _localeText.trackRide,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  cancelRideBtn(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      highlightColor: Colors.yellow[600],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReviewScreen(),
          ),
        );
      },
      height: size.height * 0.05,
      minWidth: size.width * 0.8,
      color: AppColors.primaryColor,
      child: Text(
        _localeText.cancelRide,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
