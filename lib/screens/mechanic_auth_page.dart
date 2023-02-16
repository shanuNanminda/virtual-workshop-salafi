import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_workshop/screens/user_home_page.dart';
import 'package:virtual_workshop/services/http_services.dart';

class WorkshopAuthPage extends StatefulWidget {
  WorkshopAuthPage({super.key});
  static String routeName = 'WorkshopAuthPage';
  @override
  State<WorkshopAuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<WorkshopAuthPage> {
  bool isLogin = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController minWageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  LocationData? locationData;
CarouselController carController=CarouselController();
  signUp() async {
    if (formkey.currentState!.validate()) {
      print('sending');
      // Response res=await post(Uri.parse('http://192.168.68.167:8000/user_registration'));
      // print(res.body);
      final data = await HttpServices.postData(
        params: {
          'username': usernameController.text,
          'workshop_name': nameController.text,
          'password1': passwordController.text,
          'password2': passwordController.text,
          'address': addressController.text,
          'phone_number': phoneController.text,
          'location':locationController.text,
          'min_wage':minWageController.text,
        },
        endPoint: 'Mechanic_registration',
      );
      print(data);
      if (data['result']) {
        Navigator.pushNamed(context, UserHomePage.routeName);
      }
    }
  }

  fetchLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      locationController.text =
          '${locationData!.latitude},${locationData!.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(isLogin ? 'Login' : 'SignUp',
                      style: TextStyle(
                        fontSize: 30,
                      )),
                ),
                Lottie.asset('assets/car_and_user.json'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'enter username';
                      }
                    },
                    controller: usernameController,
                    decoration: InputDecoration(
                      label: Text('username'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
               if(!isLogin) Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
               if(!isLogin) Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'location is not given';
                      }
                    },
                    controller: locationController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: fetchLocation,
                          icon: Icon(Icons.location_on)),
                      label: Text('location'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                if (!isLogin)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      maxLines: 4,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'enter address';
                        }
                      },
                      controller: addressController,
                      decoration: InputDecoration(
                        label: Text('address'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                if (!isLogin)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'enter phone';
                        }
                      },
                      controller: phoneController,
                      decoration: InputDecoration(
                        label: Text('phone'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  if (!isLogin)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'enter min wage';
                        }else if(int.parse(v)<1){
                          return 'enter minimum amount';
                        }
                      },
                      controller: minWageController,
                      decoration: InputDecoration(
                        label: Text('min wage'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'enter password';
                      }
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: Text('password'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(HomePage.routeName);
                       isLogin? null :signUp();
                      },
                      child: Text(isLogin ? 'Login' : 'SignUp')),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {Navigator.pushNamed(context, WorkshopAuthPage.routeName);
                        },
                        child:
                            Text(isLogin ? 'SignUp instead?' : 'SignUp instead')),
                            TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child:
                            Text(isLogin ? 'SignUp instead?' : 'SignUp instead')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
