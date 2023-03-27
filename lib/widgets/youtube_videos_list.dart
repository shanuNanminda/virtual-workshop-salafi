import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_workshop/services/http_services.dart';
import 'package:virtual_workshop/widgets/youtube_image_card.dart';

import '../constants.dart';
import '../screens/youtube_video_webview.dart';

class YoutubeVideosList extends StatelessWidget {
  YoutubeVideosList({super.key, required this.forUser});

  bool forUser;

  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();

    List data = await HttpServices.getData('Ytlink');
    data.where(
      (element) => element['id'] == spref.getString('userId'),
    );
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: forUser ? HttpServices.getData('Ytlink') : getData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snap.hasData) {
            // showMenu(context: context, position: RelativeRect.fromDirectional(textDirection: textDirection, start: start, top: top, end: end, bottom: bottom), items: items)
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    // launchUrl(Uri.parse(Constants.youtubeLinks[index]['url']!));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => YoutubeVideoWebview(
                                url: snap.data[index]['link']!)));
                  },
                  child: YoutubeImageCard(
                    thumbnailImage:
                        '${snap.data[index]['link']!.replaceAll('https://www.youtube.com/watch?v=', 'https://i.ytimg.com/vi/').replaceAll('https://youtu.be/', 'https://i.ytimg.com/vi/')}/hq720.jpg',
                    imageTitle: snap.data[index]['description']!,
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/no_data.json'),
                  Text(
                    'No Mechanics found',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            );
          }
        });
  }
}
