import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/http_services.dart';

class RequestView extends StatelessWidget {
  RequestView({super.key, required this.index});
  int index;
  Future<dynamic> getData() async {
    final data = await HttpServices.getData('Wrequest_view');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snap.hasData) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name: ${snap.data![index]['name']}',
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'phone: ${snap.data![index]['phone_number']}',
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'problem: ${snap.data![index]['problem']}',
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'vehicle: ${snap.data![index]['vehicle_model']}',
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text('No data'),
              );
            }
          }),
    );
  }
}
