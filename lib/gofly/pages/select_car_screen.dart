import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texi_booking/models/car_model.dart';
import 'package:texi_booking/pages/payment/payment_option_screen.dart';
import 'package:texi_booking/utils/app_colors.dart';
import 'package:texi_booking/utils/strings.dart';
import 'package:texi_booking/widgets/app_widgets/app_bar.dart';
import 'package:texi_booking/widgets/map_widget.dart';

class SelectCarScreen extends StatefulWidget {
  @override
  _SelectCarScreenState createState() => _SelectCarScreenState();
}

class _SelectCarScreenState extends State<SelectCarScreen> {
  Size size;
  List<CarList> cars = [
    CarList(
      images: StringValue.TOYOTA,
      name: "Toyota car",
      seat: "6 seat",
    ),
    CarList(
      images: StringValue.HONDA,
      name: "Honda car",
      seat: "4 seat",
    ),
    CarList(
      images: StringValue.TOYOTA,
      name: "Toyota car",
      seat: "6 seat",
    ),
    CarList(
      images: StringValue.HONDA,
      name: "Honda car",
      seat: "4 seat",
    ),
    CarList(
      images: StringValue.TOYOTA,
      name: "Toyota car",
      seat: "6 seat",
    ),
    CarList(
      images: StringValue.HONDA,
      name: "Honda car",
      seat: "4 seat",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            MapWidget(),
            Column(
              children: [
                Spacer(),
                Container(
                  height: size.height * 0.446,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, -5))
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 30),
                        child: Row(
                          children: [
                            Icon(Icons.my_location),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                "85 W,Jockey street park forest,ILL 60466",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.001,
                        margin: EdgeInsets.only(left: 55),
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              StringValue.RIGHTARROW,
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                "64 W,Rockland forest,ILL 60466",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.001,
                        color: Colors.grey[300],
                        margin: EdgeInsets.only(left: 55),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: cars.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PaymentMethodScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10.0,
                                  ),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0, color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SvgPicture.asset(
                                          cars[index].images,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cars[index].name,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            cars[index].seat,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 15,
                                              ),
                                              Text(
                                                " 12:35AM-12:45AM",
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 25,
                                            width: size.width * 0.17,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0)),
                                              color: AppColors.primaryColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "\$105",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///[AppBar]
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: APPBAR(
                menu: true,
                visiable: false,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.35, left: size.width * 0.85),
              height: 55,
              width: 55,
              color: Colors.white,
              child: Icon(
                Icons.my_location,
                size: 32.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
