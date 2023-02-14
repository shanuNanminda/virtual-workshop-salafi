import 'package:flutter/material.dart';
import 'package:virtual_workshop/constants.dart';
import 'package:virtual_workshop/widgets/youtube_image_card.dart';

import '../widgets/user_main_drawer.dart';
import 'youtube_video_webview.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  static String routeName = 'UserHomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserMainDrawer(),
      appBar: AppBar(
        title: Text('Virtual Workshop'),
      ),
      body: ListView.builder(
        itemCount: Constants.youtubeLinks.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              // launchUrl(Uri.parse(Constants.youtubeLinks[index]['url']!));
              Navigator.pushNamed(context, YoutubeVideoWebview.routeName);
            },
            child: YoutubeImageCard(
              thumbnailImage:
                  '${Constants.youtubeLinks[index]['url']!.replaceAll('https://www.youtube.com/watch?v=', 'https://i.ytimg.com/vi/')}/hq720.jpg',
              imageTitle: Constants.youtubeLinks[index]['name']!,
            ),
          );
        },
      ),
    );
  }
}
