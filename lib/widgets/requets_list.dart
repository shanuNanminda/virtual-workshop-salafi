import 'package:flutter/material.dart';
import 'package:virtual_workshop/services/http_services.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({super.key});

  getData() async {
    final data=await HttpServices.getData('Wrequest_view');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snap.hasData) {
            return ListView.builder(itemBuilder: (_, index) {
              return ListTile();
            });
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
