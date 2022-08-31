import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:texi_booking/models/locales_models.dart';
import 'package:texi_booking/models/locales_provider_model.dart';
import 'package:texi_booking/utils/app_colors.dart';
import 'package:texi_booking/utils/strings.dart';
import 'package:texi_booking/widgets/bar_chart.dart';
import 'package:texi_booking/widgets/kf_drawer.dart';

class PaymentDetailsScreen extends KFDrawerContent {
  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  Size size;
  List image = [
    StringValue.TOYOTA,
    StringValue.HONDA,
    StringValue.TOYOTA,
    StringValue.HONDA,
    StringValue.TOYOTA,
    StringValue.HONDA,
    StringValue.TOYOTA,
    StringValue.HONDA,
    StringValue.TOYOTA,
    StringValue.HONDA,
  ];
  List name = [
    "Quick Taxi",
    "MyTrip Taxi",
    "MyTrip Taxi",
    "Quick Taxi",
    "MyTrip Taxi",
    "MyTrip Taxi",
    "Quick Taxi",
    "MyTrip Taxi",
    "MyTrip Taxi",
    "Quick Taxi",
  ];

  List rate = [
    "\$8.25",
    "\$30.25",
    "\$18.25",
    "\$16.25",
    "\$10.25",
    "\$7.25",
    "\$3.25",
    "\$22.25",
    "\$14.25",
    "\$11.25",
  ];

  PaymentDetailsModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .paymentDetailsScreen;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: widget.onMenuPressed,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          _localeText.paymentDetails,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(0.1),
                      offset: Offset(0, 5))
                ],
                color: AppColors.primaryColor),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 20.0, top: 40.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey.withOpacity(0.1),
                                offset: Offset(0, 5))
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          SizedBox(height: 50.0),
                          Text(
                            "\$75.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_localeText.paymentDate),
                                Text("12 oct,2020"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_localeText.paymentMethod),
                                Flexible(
                                    child: Text(
                                  "Pay via Master card",
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_localeText.to),
                                Text("VIP taxi"),
                              ],
                            ),
                          ),
                          Divider(),
                          Text(
                            _localeText.fullDetails,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      )),
                  Positioned(
                    left: size.width * 0.38,
                    top: size.width * -0.06,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Payment History",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  BarChartSample(),
                  Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10.0, top: 5, left: 15),
                    child: Row(
                      children: [
                        Text(
                          _localeText.youSpend,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(" \$150.75 "),
                        Text(
                          _localeText.onThisMon,
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Flexible(
                          child: Text(
                            _localeText.all,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(image.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: size.height * 0.1,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Container(
                                    height: size.width * 0.2,
                                    width: size.width * 0.25,
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.yellow[100],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(image[index]),
                                    )),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15.0),
                                      Text(
                                        name[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "9 oct 2020",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Text(rate[index])
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
