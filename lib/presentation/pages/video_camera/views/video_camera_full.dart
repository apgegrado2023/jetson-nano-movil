import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/cubit/information_device_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/cubit/video_camera_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/widgets/camera_two.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoCameraFull extends StatefulWidget {
  final Uri uri;
  final String title;

  const VideoCameraFull({
    super.key,
    required this.uri,
    required this.title,
  });
  @override
  State<VideoCameraFull> createState() => _VideoCameraFullState();
}

class _VideoCameraFullState extends State<VideoCameraFull> {
  late WebViewController controller;
  bool _isConnected = false;
  bool _isNoConnected = true;
  Connection connection = Connection.disconected;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              connection = Connection.loading;
            });
            print('Page init: $url');
          },
          onPageFinished: (String url) {
            setState(() {
              connection = Connection.connected;
            });
            print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              connection = Connection.disconected;
            });
            print('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.uri.path)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(widget.uri);
    super.initState();
  }

  @override
  void dispose() {
    controller.clearCache();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<VideoCameraCubit, VideoCameraState>(
      builder: (context, state) {
        final status = state.statusConnection;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(
                            255,
                            51,
                            51,
                            51,
                          ),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(
                            255,
                            51,
                            51,
                            51,
                          ),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                controller.reload();
                                connection = Connection.loading;
                              });
                            },
                            icon: Icon(Icons.replay_outlined)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: screenHeight + 100,
                      height: screenHeight,
                      child: Container(
                        height: 250,
                        width: screenWidth,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            WebViewWidget(controller: controller),
                            if (connection == Connection.loading)
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 8, 8, 8),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Conectando...',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (connection == Connection.disconected ||
                                status == StatusConnection.disconnected)
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 8, 8, 8),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.portable_wifi_off,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Sin conexión',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
