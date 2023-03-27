import 'package:flutter/material.dart';
import 'package:virtual_workshop/screens/request_view.dart';
import 'package:virtual_workshop/services/http_services.dart';
import 'package:virtual_workshop/services/location_services.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({super.key});

  Future<dynamic> getData() async {
    final data = await HttpServices.getData('Wrequest_view');
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
          } else if (snap.data.length < 1) {
            return Center(child: Text('No data'));
          } else if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RequestView(index: index),
                          ),
                        );
                        ;
                      },
                      title: Text(snap.data![index]['name']),
                      subtitle: FutureBuilder(
                          future: LocationServices.getPlaceName(
                            snap.data![index]['location'].split(',')[0],
                            snap.data![index]['location'].split(',')[1],
                          ),
                          builder: (context, snapp) {
                            if (snapp.hasData) {
                              return Text(snapp.data!);
                            } else {
                              return Text('...');
                            }
                          }),
                    ),
                  );
                });
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
