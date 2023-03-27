import 'package:flutter/material.dart';
import 'package:virtual_workshop/constants.dart';
import 'package:virtual_workshop/widgets/nearest_mechanics_list.dart';

import '../widgets/user_main_drawer.dart';
import '../widgets/youtube_videos_list.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  static String routeName = 'UserHomePage';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: UserMainDrawer(),
        appBar: AppBar(
          title: Text('CallMech'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Mechanics',
              ),
              Tab(
                text: 'videos',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
        NearestMechanicsList(),
          YoutubeVideosList(forUser: true),
        ]),
      ),
    );
  }
}
