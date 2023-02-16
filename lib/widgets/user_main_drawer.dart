import 'package:flutter/material.dart';
import 'package:virtual_workshop/screens/workshop_list_page.dart';

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
            )
          ],
        ),
      ),
    );
  }
}
