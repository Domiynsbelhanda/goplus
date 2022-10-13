import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class QuizWebView extends StatefulWidget {
  QuizWebView({Key? key}) : super(key: key);

  @override
  State<QuizWebView> createState() => _QuizWebView();
}

class _QuizWebView extends State<QuizWebView> {

  late Size size;
  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              WebViewX(
                initialContent: 'https://go-plus.info/open/qcm',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) => webviewController = controller,
                width: size.width,
                height: size.height,
              ),

              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CloseButton(),
                ),
              )
            ],
          ),
        )
    );
  }
}