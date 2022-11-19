import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_colors.dart';

class AboutPage extends KFDrawerContent {
  AboutPage({
    Key? key
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AboutPage();
  }
}

class _AboutPage extends State<AboutPage>{

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ToastContext().init(context);

    return Stack(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(48.0)
                  ),
                  child: IconButton(
                    onPressed: widget.onMenuPressed,
                    icon: const Icon(
                      Icons.menu,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    child: const Text(
                      'GO+, une application de location de VTC proposée par la société GO FLY.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0
                      ),
                    ),
                  ),

                  const SizedBox(height: 16.0,),

                  GestureDetector(
                    onTap: (){makeWebsite('https://www.gofly-world.com');},
                    child: const Text(
                      'www.gofly-world.com',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> makeWebsite(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}