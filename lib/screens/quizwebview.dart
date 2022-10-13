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
                initialContent: 'https://domiyns.com/',
                initialSourceType: SourceType.url,
                onWebViewCreated: (controller) => webviewController = controller,
                width: size.width,
                height: size.height,
              )
            ],
          ),
        )
    );
  }
}