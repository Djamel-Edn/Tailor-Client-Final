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
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            // Future.delayed(Duration(milliseconds: 800), () {
            //   controller.scrollTo(8, 168);
            //   controller.scrollBy(
            //       0, (MediaQuery.of(context).size.width * 1.1).toInt());
            //   setState(() {});
            // });
          },
          onPageFinished: (String url) {
            // print("finish");

            // Future.delayed(Duration(milliseconds: 800), () {
            //   controller.scrollTo(8, 168);
            //   controller.scrollBy(
            //       0, (MediaQuery.of(context).size.width * 1.1).toInt());
            //   setState(() {});
            // });
          },
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
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     controller.scrollTo(0, 0);
    //   });
    // });
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
