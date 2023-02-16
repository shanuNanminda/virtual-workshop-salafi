
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:virtual_workshop/models/workshop_model.dart';
import 'package:virtual_workshop/services/http_services.dart';
import 'package:virtual_workshop/services/location_services.dart';
import 'package:virtual_workshop/services/math_services.dart';

class WorkshopListPage extends StatelessWidget {
  WorkshopListPage({super.key});
  static const String routeName = 'workshop list page';

  List<WorkShop> workshops = [];
  getData(BuildContext context) async {
    final locData = await LocationServices.getLoc();
    if (!(locData is LocationData)) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Location error'),
                content:
                    Text('Kindly enable location permission in app settings'),
              ));
    } else {
      var data = await HttpServices.getData('workshop');
      if (data is List) {
        workshops = data.map((e) => WorkShop.fromJson(e)).toList();
      }
      workshops.forEach((element) {
       element.distance= MathServices.calculateDistance(locData.latitude, locData.longitude,
            element.location.split(',').first, element.location.split(',')[1]);
      });
      workshops.sort((a, b) => a.distance.compareTo(b.distance),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getData(context),
        builder: (context, snapshot) {
          return Card(
            child: ListView.builder(
              itemCount: workshops.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(workshops[index].workshopName),
                  subtitle: Text(workshops[index].phoneNumber),
                  trailing: Text(workshops[index].location),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
