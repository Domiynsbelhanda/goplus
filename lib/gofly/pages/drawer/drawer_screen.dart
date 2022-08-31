import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texi_booking/pages/drawer/my_profile_screen.dart';
import 'package:texi_booking/utils/app_colors.dart';
import 'package:texi_booking/utils/class_builder.dart';
import 'package:texi_booking/utils/strings.dart';
import 'package:texi_booking/widgets/kf_drawer.dart';

class DrawerScreen extends KFDrawerContent {
  String screen;
  DrawerScreen({this.screen});
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with TickerProviderStateMixin {
  Size size;
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('DestinationScreen'),
      items: [
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 15, top: 15),
            child: Text('Home', style: TextStyle(color: Colors.white)),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: SvgPicture.asset(
              StringValue.HOME,
              height: 20,
            ),
          ),
          page: ClassBuilder.fromString('DestinationScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 15, top: 15),
            child: Text(
              'Your Ride',
              style: TextStyle(color: Colors.white),
            ),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: SvgPicture.asset(
              StringValue.YOURRIDE,
            ),
          ),
          page: ClassBuilder.fromString('YourRidesScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 39, bottom: 15, top: 15),
            child: Text(
              'Payment',
              style: TextStyle(color: Colors.white),
            ),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: SvgPicture.asset(
              StringValue.PAYMENT,
            ),
          ),
          page: ClassBuilder.fromString('PaymentDetailsScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
              padding: const EdgeInsets.only(left: 39, bottom: 15, top: 15),
              child: Text('Message', style: TextStyle(color: Colors.white))),
          icon: Container(
              margin: const EdgeInsets.only(bottom: 15, top: 15),
              child: SvgPicture.asset(StringValue.MESSAGE)),
          page: ClassBuilder.fromString('MessagesScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 42, bottom: 15, top: 15),
            child: Text(
              'Notification',
              style: TextStyle(color: Colors.white),
            ),
          ),
          icon: Container(
              margin: const EdgeInsets.only(bottom: 15, top: 15),
              child: SvgPicture.asset(StringValue.NOTIFICATION)),
          page: ClassBuilder.fromString('NotificationsScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 35, bottom: 15, top: 15),
            child: Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
          page: ClassBuilder.fromString('DestinationScreen'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfileScreen(),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Evaana Musk",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Richmond Hill, NY 11419",
                      style: TextStyle(color: Colors.white, fontSize: 12))
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        footer: KFDrawerItem(
          text: Container(
            margin: EdgeInsets.only(left: 30),
            child: Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
          ),
          icon: SvgPicture.asset(StringValue.LOGOUT),
          onPressed: () {
            if (widget.screen == 'login') {
              Navigator.pop(context);
            } else {
              Navigator.of(context)..pop()..pop()..pop()..pop();
            }
          },
        ),
        decoration: BoxDecoration(color: AppColors.primaryColor),
      ),
    );
  }
}
