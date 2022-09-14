import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/gofly/pages/drawer/payment_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_bar.dart';
import 'package:goplus/gofly/widgets/kf_drawer.dart';
import 'package:goplus/gofly/widgets/map_widget.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';

import '../cancel_ride_screen.dart';

class PaymentMethodScreen extends KFDrawerContent {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late Size size;
  final scaffoldState = GlobalKey<ScaffoldState>();

  late PaymentOptionModel _localeText;

  @override
  void initState() {
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .paymentOptionScreen!;
    Future.delayed(Duration(seconds: 0)).then((_) {
      bottomSheet();
    });
    super.initState();
  }

  @override
  Widget build(context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: GestureDetector(
          onTap: bottomSheet,
          child: Container(
            height: size.height * 0.005,
            width: size.width * 0.2,
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            /// [Map]
            MapWidget(),

            ///[AppBar]
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: APPBAR(
                menu: true,
                onTap: widget.onMenuPressed,
                visiable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: size.height * 0.005,
                width: size.width * 0.2,
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
              ),
            ),
            Container(
              height: size.height * 0.12,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey)],
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SvgPicture.asset(
                        StringValue.TOYOTA,
                        fit: BoxFit.contain,
                        width: 80,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toyota car",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("6 seat", style: TextStyle(fontSize: 14)),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: size.height * 0.04,
                        width: size.width * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: AppColors.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "\$5",
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
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 10,
                    ),
                    child: Text(
                      'Information sur le chauffeur',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Prix par 30 min : 5\$',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    height: 0.5,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  ListTile(
                    title: Text(
                      'Couleur : Bleu',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    )
                  ),
                  Container(
                    color: Colors.grey[300],
                    height: 0.5,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 10,
                    ),
                    child: Text(
                      _localeText.paymentMethod,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(StringValue.CASH),
                    title: Text(
                      'Payer Cash',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ),
                  // Container(
                  //   color: Colors.grey[300],
                  //   height: 0.5,
                  //   margin: EdgeInsets.symmetric(horizontal: 15),
                  // ),
                  // ListTile(
                  //   leading: SvgPicture.asset(StringValue.CASH),
                  //   title: Text(
                  //     'Mobile Money',
                  //     style: TextStyle(
                  //       fontSize: 12.0,
                  //     ),
                  //   ),
                  //   trailing: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.grey[300],
                  //   height: 0.5,
                  //   margin: EdgeInsets.symmetric(horizontal: 15),
                  // ),
                  // ListTile(
                  //   leading: SvgPicture.asset(StringValue.MASTER),
                  //   title: Text(
                  //     _localeText.payWithMaster,
                  //     style: TextStyle(
                  //       fontSize: 12.0,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: SvgPicture.asset(
                  //     StringValue.PAYPAL,
                  //   ),
                  //   title: Text(
                  //     _localeText.payWithPaypal,
                  //     style: TextStyle(
                  //       fontSize: 12.0,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: Container(
                  //     height: size.width * 0.1,
                  //     width: size.width * 0.1,
                  //     child: SvgPicture.asset(StringValue.VISA),
                  //   ),
                  //   title: Text(
                  //     _localeText.payWithVisa,
                  //     style: TextStyle(
                  //       fontSize: 12.0,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.grey[300],
                  //   height: 0.5,
                  //   margin: EdgeInsets.symmetric(horizontal: 15),
                  // ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              highlightColor: Colors.yellow[600],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CancelRideScreen()
                  ),
                );
              },
              height: size.height * 0.05,
              minWidth: size.width * 0.8,
              color: AppColors.primaryColor,
              child: Text(
                _localeText.bookRide,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        );
      },
    );
  }
}
