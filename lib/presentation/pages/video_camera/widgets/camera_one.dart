import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/cubit/information_device_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/cubit/video_camera_cubit.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/views/video_camera_full.dart';
import 'package:flutter_application_prgrado/presentation/pages/video_camera/widgets/camera_two.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CameraOne extends StatefulWidget {
  const CameraOne({super.key, required this.uri});
  final Uri uri;

  @override
  State<CameraOne> createState() => _CameraOneState();
}

class _CameraOneState extends State<CameraOne> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<VideoCameraCubit, VideoCameraState>(
      builder: (context, state) {
        final status = state.statusConnection;
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(
              255,
              51,
              51,
              51,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                height: 250,
                width: screenWidth,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: WebViewWidget(controller: controller)),
                    Container(
                      height: 10,
                      color: Colors.black,
                    ),
                    if (connection == Connection.loading)
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 8, 8, 8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
              Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
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
                          onPressed: () {
                            setState(() {
                              controller.reload();
                              connection = Connection.loading;
                            });
                          },
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
                                builder: (context) => VideoCameraFull(
                                  uri: widget.uri,
                                  title: 'Cámara 1',
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
        );
      },
    );
  }
}
