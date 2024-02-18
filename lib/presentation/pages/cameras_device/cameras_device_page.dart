import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CamerasDevicePage extends StatelessWidget {
  const CamerasDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CamerasDeviceView();
  }
}

class CamerasDeviceView extends StatefulWidget {
  const CamerasDeviceView({super.key});

  @override
  State<CamerasDeviceView> createState() => _CamerasDeviceViewState();
}

class _CamerasDeviceViewState extends State<CamerasDeviceView> {
  late WebViewController controller;
  late WebViewController controller2;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('http://192.168.3.58:5000/video_feedOne')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://192.168.3.58:5000/video_feedOne'));

    controller2 = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('http://192.168.3.58:5000/video_feedTwo')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://192.168.3.58:5000/video_feedTwo'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //WebViewWidget(controller: controller),
              Container(
                  height: 224,
                  width: 224,
                  child: WebViewWidget(controller: controller2)),
              Container(
                  height: 224,
                  width: 224,
                  child: WebViewWidget(controller: controller)),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
