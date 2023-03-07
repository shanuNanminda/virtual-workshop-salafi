import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_workshop/services/http_services.dart';

class NearestMechanicsList extends StatelessWidget {
  NearestMechanicsList({super.key});

  late LocationData loc;
  Future<dynamic> getData() async {
    print('zxcvzxcvzxcvzxcvxcv');
    loc = await Location.instance.getLocation();
    var data = await HttpServices.getData('workshopview');
    print(data);
    // Fluttertoast.showToast(msg: data['result']);
    return data;
  }

  double calculateDistance(lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - loc.latitude) * p) / 2 +
        c(loc.latitude! * p) *
            c(lat2 * p) *
            (1 - c((lon2 - loc.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

//   {
//     "id": 1,
//     "customer": 1,
//     "workshop": 1,
//     "name": "asdf",
//     "location": "12.234,12.345",
//     "date": "2012-12-12",
//     "time": "12:12:00",
//     "status": "0",
//     "phone_number": "2345678",
//     "problem": "asfgd",
//     "vehicle_model": "adsf"
// }

  TextEditingController nameController = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController problem = TextEditingController();
  TextEditingController model = TextEditingController();

  showRequestForm(BuildContext context, String id) async {
   showModalBottomSheet(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        // backgroundColor: Colors.black,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'enter name';
                  }
                },
                controller: nameController,
                decoration: InputDecoration(
                  label: Text('name'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'enter phone';
                  }
                },
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Text('phone'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'enter problem';
                  }
                },
                controller: problem,
                decoration: InputDecoration(
                  label: Text('problem'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'enter model';
                  }
                },
                controller: model,
                decoration: InputDecoration(
                  label: Text('model'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sendRequest(id,context);
              },
              child: Text('Send Request'),
            )
          ],
        ),
      ),
    );
  }

  sendRequest(String id,BuildContext context) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    LocationData loc = await Location.instance.getLocation();

Map data=  await  HttpServices.postData(params: {
      "id": id,
      "customer": spref.getString('userId'),
      "workshop": id,
      "name": nameController.text,
      "location": '${loc.latitude},${loc.longitude}',
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "time": '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}',
      "status": "0",
      "phone_number": phone.text,
      "problem": problem.text,
      "vehicle_model": model.text,
    }, endPoint: 'Wrequest_view');
    if(data['id']!=null){
Fluttertoast.showToast(msg: 'Requested succesfully');
Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snap.hasData) {
          (snap.data as List).sort(
            (a, b) => calculateDistance(
                    a['location'].split(',').first, a['location'].split(',')[1])
                .round(),
          );
          return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snap.data![index]['workshop_name'],
                    ),
                    subtitle: Text(
                      snap.data![index]['phone_number'],
                    ),
                    trailing: ElevatedButton(
                        onPressed: () {
                          showRequestForm(context,'${snap.data![index]['id']}');
                        },
                        child: Text('Request')),
                  ),
                );
              });
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
      },
    );
  }
}
