import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoStreamPage extends StatefulWidget {
  @override
  _VideoStreamPageState createState() => _VideoStreamPageState();
}

class _VideoStreamPageState extends State<VideoStreamPage> {
  String videoData = '';

  void fetchVideo() async {
    final response =
        await http.get(Uri.parse('http://192.168.3.58:5000/video'));

    print(response);
    /*if (response.statusCode == 200) {*/
    setState(() {
      videoData = response.body;
      print(response.body);
    });
    /*}*/
  }

  @override
  void initState() {
    super.initState();
    fetchVideo();
  }

  @override
  Widget build(BuildContext context) {
    print("se construyeasd");
    print(videoData.isNotEmpty);
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Stream en Base64'),
      ),
      body: Center(
        child: videoData.isNotEmpty
            ? Image.memory(
                Uint8List.fromList(
                  base64Decode(
                    (videoData.toString()),
                  ),
                ),
                gaplessPlayback: true,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VideoStreamPage(),
  ));
}

/**import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    /*_controller =
        VideoPlayerController.network('http://192.168.3.58:5000/video_feed');

    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
    _controller.setLooping(false);
*/
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
            if (request.url.startsWith('http://192.168.3.58:5000/video_feed')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://192.168.3.58:5000/video_feed'));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
 */