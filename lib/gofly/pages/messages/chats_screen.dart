import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/custom_clipper.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late Size size;
  late ChatsModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .chatsScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "John Cruzz",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "KA 00 AB 0000",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "Today at 03:30 PM",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipPath(
                        clipper: CustomRRectClipper(left: false),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 20, top: 15, bottom: 30),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Text(
                            "Hello, are you near by?",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipPath(
                        clipper: CustomRRectClipper(left: true),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 20, top: 15, bottom: 30),
                          decoration: BoxDecoration(
                            color: Color(0xffe3e7f1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            "I'll be there in a few minutes",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipPath(
                        clipper: CustomRRectClipper(left: false),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 20, top: 15, bottom: 30),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Text(
                            "Okay, I'am in front of the\n bus stop",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    " 03:55 PM",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipPath(
                        clipper: CustomRRectClipper(left: true),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 20, top: 15, bottom: 30),
                          decoration: BoxDecoration(
                              color: Color(0xffe3e7f1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Text(
                            "sorry, I'm stuck in traffic.\nPlease give me a moment.",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
          SafeArea(
            child: Container(
              height: size.height * 0.1,
              width: size.width,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey.withOpacity(0.1),
                    offset: Offset(-5, -5))
              ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: _localeText.typeMessage,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (_) => MessagesScreen(
                        //         isPage: true,
                        //       ),
                        //     ));
                      },
                      child: Icon(
                        Icons.send,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
