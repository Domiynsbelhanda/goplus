import 'package:flutter/material.dart';
import 'package:texi_booking/pages/messages/chats_screen.dart';
import 'package:texi_booking/widgets/kf_drawer.dart';

class MessagesScreen extends KFDrawerContent {
  final bool isPage;
  MessagesScreen({this.isPage});
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Size size;

  List name = [
    "Manojbhai",
    "Yash",
    "Kirtan",
    "Prashant",
    "Sunny",
    "Manojbhai",
    "Yash",
    "Kirtan",
    "Prashant",
    "Sunny",
  ];
  List time = [
    "I m waiting for you",
    "22 minutes ago",
    "27 minutes ago",
    "30 minutes ago",
    "34 minutes ago",
    "38 minutes ago",
    "41 minutes ago",
    "49 minutes ago",
    "56 minutes ago",
    "59 minutes ago",
  ];
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
        title: Text(
          "Message",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xfff1f3f9),
              ),
              child: Center(
                child: TextField(
                  cursorColor: Colors.yellow,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    contentPadding: EdgeInsets.all(15.0),
                  ),
                ),
              ),
            ),
            Container(
              height: size.height * 0.77,
              child: ListView.builder(
                itemCount: name.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Chats(),
                            ));
                      },
                      child: Container(
                        height: size.height * 0.1,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 1,
                              color: Colors.grey.withOpacity(0.1),
                              offset: Offset(-5, -5))
                        ], color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.grey[200],
                                child: Icon(Icons.person, color: Colors.grey),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      time[index],
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                "3:35 PM",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
