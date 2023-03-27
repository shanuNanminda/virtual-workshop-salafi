import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_workshop/services/http_services.dart';
import 'package:virtual_workshop/widgets/mechanic_drawer.dart';

import '../constants.dart';
import '../widgets/requets_list.dart';
import '../widgets/youtube_videos_list.dart';

class MechanicHomePage extends StatelessWidget {
  const MechanicHomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: 'videos',
            ),
            Tab(
              text: 'requests',
            ),
          ]),
        ),
        drawer: MechanicDrawer(),
        body: TabBarView(
          children: [
           YoutubeVideosList(forUser: false),
            RequestsList(),
          ],
        ),
      ),
    );
  }
}
