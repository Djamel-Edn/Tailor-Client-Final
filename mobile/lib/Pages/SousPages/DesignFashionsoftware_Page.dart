import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DesignFashinSoft extends StatefulWidget {
  const DesignFashinSoft({super.key});

  @override
  State<DesignFashinSoft> createState() => _DesignFashinSoftState();
}

class _DesignFashinSoftState extends State<DesignFashinSoft> {
  late WebViewController controller;
  late ScrollController scrollController = ScrollController();
  // late Timer _timer;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(true)
      ..getScrollPosition()
      ..scrollBy(8, 180)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://tailornova.com/designer'));
    super.initState();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFF4DE),
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      )),
    );
  }
}
