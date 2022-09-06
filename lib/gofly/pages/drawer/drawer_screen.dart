import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goplus/gofly/pages/drawer/my_profile_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/class_builder.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/kf_drawer.dart';

class DrawerScreen extends KFDrawerContent {
  String? screen;
  DrawerScreen({ this.screen});
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with TickerProviderStateMixin {
  late Size size;
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('DestinationScreen'),
      items: [
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 15, top: 15),
            child: Text('Accueil', style: TextStyle(color: Colors.black)),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: SvgPicture.asset(
              StringValue.HOME,
              height: 20,
              color: Colors.black,
            ),
          ),
          page: ClassBuilder.fromString('DestinationScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 15, top: 15),
            child: Text(
              'Vos Trajets',
              style: TextStyle(color: Colors.black),
            ),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: SvgPicture.asset(
              StringValue.YOURRIDE,
              color: Colors.black,
            ),
          ),
          page: ClassBuilder.fromString('YourRidesScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 39, bottom: 15, top: 15),
            child: Text(
              'Paiements',
              style: TextStyle(color: Colors.black),
            ),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: SvgPicture.asset(
              StringValue.PAYMENT,
              color: Colors.black,
            ),
          ),
          page: ClassBuilder.fromString('PaymentDetailsScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
              padding: const EdgeInsets.only(left: 39, bottom: 15, top: 15),
              child: Text('Message', style: TextStyle(color: Colors.black))),
          icon: Container(
              margin: const EdgeInsets.only(bottom: 15, top: 15),
              child: SvgPicture.asset(StringValue.MESSAGE, color: Colors.black,)),
          page: ClassBuilder.fromString('MessagesScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 42, bottom: 15, top: 15),
            child: Text(
              'Notification',
              style: TextStyle(color: Colors.black),
            ),
          ),
          icon: Container(
              margin: const EdgeInsets.only(bottom: 15, top: 15),
              child: SvgPicture.asset(StringValue.NOTIFICATION, color: Colors.black,)),
          page: ClassBuilder.fromString('NotificationsScreen'),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: const EdgeInsets.only(left: 35, bottom: 15, top: 15),
            child: Text(
              'Parametres',
              style: TextStyle(color: Colors.black),
            ),
          ),
          icon: Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            child: Icon(
              Icons.settings,
              color: Colors.black,
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
        header: Padding(
          padding: EdgeInsets.only(top: 48.0),
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
                  Text("Youness Dominique",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("youness.dominique@gmail.com",
                      style: TextStyle(color: Colors.black, fontSize: 12))
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        footer: Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: KFDrawerItem(
            text: Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                'Deconnexion',
                style: TextStyle(color: Colors.black),
              ),
            ),
            icon: SvgPicture.asset(StringValue.LOGOUT, color: Colors.black,),
            onPressed: () {
              if (widget.screen == 'login') {
                Navigator.pop(context);
              } else {
                Navigator.of(context)..pop()..pop()..pop()..pop();
              }
            },
          ),
        ),
        decoration: BoxDecoration(color: AppColors.primaryColor),
      ),
    );
  }
}
