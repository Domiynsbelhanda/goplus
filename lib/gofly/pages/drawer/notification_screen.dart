import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/widgets/kf_drawer.dart';

import '../messages/chats_screen.dart';

class NotificationsScreen extends KFDrawerContent {
  bool isPage;
  NotificationsScreen({required this.isPage});
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Size size;

  List name = [
    "Manojbhai",
    "Yash",
    "Kirtan",
    "Prashant",
    "Sunny",
  ];
  List time = [
    "20 minutes ago",
    "22 minutes ago",
    "30 minutes ago",
    "45 minutes ago",
    "55 minutes ago",
  ];

  late NotificationModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .notificationScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          // onTap: widget.onMenuPressed,
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
        title: Text(
          _localeText.notificaitons,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Chats(),
                  ));
            },
            child: Container(
              height: size.height * 0.1,
              margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 3.0,
                  color: Colors.grey,
                )
              ], color: Colors.white),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: name[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " " + _localeText.wantsToShareCab,
                              style: TextStyle(fontSize: 14),
                            ),
                          ]),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          time[index],
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
