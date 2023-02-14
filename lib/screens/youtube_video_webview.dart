import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeVideoWebview extends StatelessWidget {
   YoutubeVideoWebview({super.key,this.url});
   static String routeName='video weview';
String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: WebView(initialUrl: url,javascriptMode: JavascriptMode.unrestricted,)),
    );
  }
}