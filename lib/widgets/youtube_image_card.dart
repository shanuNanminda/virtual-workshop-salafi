import 'package:flutter/material.dart';

class YoutubeImageCard extends StatelessWidget {
  YoutubeImageCard(
      {super.key, required this.thumbnailImage, required this.imageTitle});
  String thumbnailImage;
  String imageTitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                thumbnailImage,

                loadingBuilder: (context, child, loadingProgress) {
               loadingProgress==null?print('object'):   print('${loadingProgress.expectedTotalBytes}//${loadingProgress.cumulativeBytesLoaded}');
                  return Center(child: child,);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 10,
              ),
              child: Text(
                imageTitle,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
