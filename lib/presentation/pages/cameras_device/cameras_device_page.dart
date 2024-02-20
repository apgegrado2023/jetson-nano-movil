import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/pages/cameras_device/camera_full.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

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

  final Uri uriOne = Uri.parse('http://192.168.3.58:5000/video_feedOne');
  final Uri uriTwo = Uri.parse('http://192.168.3.58:5000/video_feedTwo');

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
            if (request.url.startsWith(uriOne.path)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(uriOne);

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
            if (request.url.startsWith(uriTwo.path)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(uriTwo);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        //color: Colors.red,
        child: SingleChildScrollView(
      child: Column(
        children: [
          //WebViewWidget(controller: controller),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                51,
                51,
                51,
              ),
              borderRadius: BorderRadius.circular(
                  20.0), // Ajusta el valor de acuerdo a tus necesidades
            ),
            child: Column(
              children: [
                Container(
                    height: 300,
                    width: screenWidth,
                    child: WebViewWidget(controller: controller)),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Cámara 1",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF151515),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.replay_outlined)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF151515),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            color: Colors.white,
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecondPage(
                                    uri: uriOne,
                                  ),
                                ),
                              );
                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp]);
                            },
                            icon: Icon(Icons.expand_sharp)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Container(
            //padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                51,
                51,
                51,
              ),
              borderRadius: BorderRadius.circular(
                  20.0), // Ajusta el valor de acuerdo a tus necesidades
            ),

            child: Column(
              children: [
                Container(
                  height: 300,
                  width: screenWidth,
                  child: WebViewWidget(
                    controller: controller2,
                    layoutDirection: TextDirection.rtl,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Cámara 2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF151515),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.replay_outlined)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF151515),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            color: Colors.white,
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecondPage(
                                    uri: uriTwo,
                                  ),
                                ),
                              );
                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp]);
                            },
                            icon: Icon(Icons.expand_sharp)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
