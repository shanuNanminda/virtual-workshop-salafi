import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_workshop/services/http_services.dart';
import 'package:virtual_workshop/widgets/mechanic_drawer.dart';

import '../constants.dart';
import '../widgets/youtube_videos_list.dart';

class MechanicHomePage extends StatelessWidget {
  const MechanicHomePage({super.key});

  getData() async {
    HttpServices.getData('endPoint');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MechanicDrawer(),
      body: FutureBuilder(builder: (context, snapshot) {
        if (snapshot.hasData) {
          return YoutubeVideosList(
            videos: Constants.youtubeLinks,
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/no_data.json'),
                Text('No Videos added',style: TextStyle(fontSize: 25),)
              ],
            ),
          );
        }
      }),
    );
  }
}
