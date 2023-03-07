import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_workshop/services/http_services.dart';
import 'package:virtual_workshop/widgets/youtube_image_card.dart';

import '../constants.dart';
import '../screens/youtube_video_webview.dart';

class YoutubeVideosList extends StatelessWidget {
   YoutubeVideosList({super.key});

  

  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HttpServices.getData('Ytlink'),
      builder: (context,snap) {
        if(snap.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else if(snap.hasData) {
        return ListView.builder(
          itemCount: snap.data.length,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                // launchUrl(Uri.parse(Constants.youtubeLinks[index]['url']!));
                Navigator.push(context, MaterialPageRoute(builder: (_)=>YoutubeVideoWebview(url:snap.data[index]['link']!)));
              },
              child: YoutubeImageCard(
                thumbnailImage:
                    '${snap.data[index]['link']!.replaceAll('https://www.youtube.com/watch?v=', 'https://i.ytimg.com/vi/').replaceAll('https://youtu.be/','https://i.ytimg.com/vi/')}/hq720.jpg',
                imageTitle: snap.data[index]['description']!,
              ),
            );
          },
        );}else{
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
      }
    );
  }
}
