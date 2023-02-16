import 'package:flutter/material.dart';
import 'package:virtual_workshop/screens/add_youtube_videos.dart';
import 'package:virtual_workshop/screens/auth_switch_page.dart';
import 'package:virtual_workshop/screens/mechanic_home_page.dart';
import 'package:virtual_workshop/screens/user_auth_page.dart';
import 'package:virtual_workshop/screens/user_home_page.dart';
import 'package:virtual_workshop/screens/mechanic_auth_page.dart';
import 'package:virtual_workshop/screens/workshop_list_page.dart';
import 'package:virtual_workshop/screens/youtube_video_webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // useMaterial3: true
      ),
      home: AuthSwitchPage(),
      routes: {
        UserAuthPage.routeName:(context) => UserAuthPage(),
        WorkshopAuthPage.routeName:(context) => WorkshopAuthPage(),
        UserHomePage.routeName:(context) => UserHomePage(),
        AddYoutubeVideo.routeName:(context) => AddYoutubeVideo(),
        WorkshopListPage.routeName:(context) => WorkshopListPage(),
        YoutubeVideoWebview.routeName:(context) => YoutubeVideoWebview(),
      },
    );
  }
}
