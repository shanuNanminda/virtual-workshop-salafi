import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
class LocationServices {
  static Future<dynamic> getLoc() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('No location enabled');
        return '';
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Permission denied');
        return '';
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  static Future<String> getPlaceName(String latitude, String longitude) async {
    try{final data = await geo.placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    // print(data);
    print(
        'placename from coordinates $latitude, $longitude>> ${data.first.locality}');
    return data.first.locality ?? 'unknown place';}on Exception catch(err){
      print(err);
      return err.toString();
    }
  }
}
