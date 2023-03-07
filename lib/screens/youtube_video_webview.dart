import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeVideoWebview extends StatefulWidget {
  YoutubeVideoWebview({super.key,required this.url});
  static String routeName = 'video weview';
  String url;

  @override
  State<YoutubeVideoWebview> createState() => _YoutubeVideoWebviewState();
}

class _YoutubeVideoWebviewState extends State<YoutubeVideoWebview> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller= WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(Uri.parse(widget.url));
  }

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: WebViewWidget(
            controller: controller,
            
          )),
    );
  }
}
