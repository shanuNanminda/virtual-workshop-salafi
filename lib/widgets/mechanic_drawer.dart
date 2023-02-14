import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:virtual_workshop/screens/add_youtube_videos.dart';

class MechanicDrawer extends StatelessWidget {
  const MechanicDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 80,
              ),
            ),
            Text('USER',style:TextStyle(fontSize: 30)),
            Divider(),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.pushNamed(context, AddYoutubeVideo.routeName);
                },
                title: Text('Add Video'),
              ),
            )
          ],
        ),
      ),
    );
  }
}