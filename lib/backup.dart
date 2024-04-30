import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse('https://app.lapentor.com/sphere/kalilo')),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                }),
          ],
        ),
      ),
    );
  }
}
