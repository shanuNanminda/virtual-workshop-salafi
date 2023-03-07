import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_workshop/services/http_services.dart';
import 'package:virtual_workshop/widgets/mechanic_drawer.dart';

import '../constants.dart';
import '../widgets/requets_list.dart';
import '../widgets/youtube_videos_list.dart';

class MechanicHomePage extends StatelessWidget {
  const MechanicHomePage({super.key});

  getData() async {
    HttpServices.getData('endPoint');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom:  const TabBar(tabs: [
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
            FutureBuilder(builder: (context, snapshot) {
              if (snapshot.hasData) {
                return YoutubeVideosList(
              
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/no_data.json'),
                      Text(
                        'No Videos added',
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                );
              }
            }),
            RequestsList(),
          ],
        ),
      ),
    );
  }
}
