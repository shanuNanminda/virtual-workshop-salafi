import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_workshop/constants.dart';
import 'package:virtual_workshop/screens/workshop_list_page.dart';

import '../screens/auth_switch_page.dart';

class UserMainDrawer extends StatelessWidget {
  const UserMainDrawer({super.key});

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
                backgroundColor: Colors.white,
              ),
            ),
            Text('USER',style:TextStyle(fontSize: 30)),
            Divider(),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.pushNamed(context, WorkshopListPage.routeName);
                },
                title: Text('Workshops'),
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
