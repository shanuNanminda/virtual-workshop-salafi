import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_workshop/constants.dart';
import 'package:virtual_workshop/screens/add_youtube_videos.dart';

import '../screens/auth_switch_page.dart';

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
                backgroundImage: NetworkImage(Constants.avatarImage),
              ),
            ),
            Text('USER', style: TextStyle(fontSize: 30)),
            Divider(),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AddYoutubeVideo.routeName);
                },
                title: Text('Add Video'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {},
                title: Text('Work requests'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async{
                  SharedPreferences spref=await SharedPreferences.getInstance();
                  spref.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AuthSwitchPage(),
                    ),
                  );
                },
                title: Text('Logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
