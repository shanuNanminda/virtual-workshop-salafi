// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:virtual_workshop/screens/mechanic_home_page.dart';
// import 'package:virtual_workshop/screens/user_home_page.dart';
// import 'package:virtual_workshop/services/http_services.dart';

// class LoginPage extends StatefulWidget {
//   LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<LoginPage> {
//   bool isLogin = false;
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   var formkey = GlobalKey<FormState>();
//   LocationData? locationData;
//   CarouselController carController = CarouselController();
//   signUp() async {
//     if (formkey.currentState!.validate()) {
//       print('sending');
//       // Response res=await post(Uri.parse('http://192.168.68.167:8000/user_registration'));
//       // print(res.body);
//       final data = await HttpServices.postData(
//         params: {
//           'username': usernameController.text,
//           'workshop_name': nameController.text,
//           'password1': passwordController.text,
//           'password2': passwordController.text,
//           'address': addressController.text,
//           'phone_number': phoneController.text,
//           'location': locationController.text,
//           'min_wage': minWageController.text,
//         },
//         endPoint: 'Mechanic_registration',
//       );
//       print(data);
//       if (data['result']) {
//         SharedPreferences.getInstance().then((value) {
//           value.setString('userType', 'mechanic');
//           if(data['id']!=null){
//           value.setString('userId', data['id']);}
//           else{
//             print('No Id');
//           }
//         });
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (ctx) => MechanicHomePage(),
//           ),
//         );
//       }
//     }
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//       ),
//       // resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Form(
//           key: formkey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Text(isLogin ? 'Login' : 'SignUp',
//                       style: TextStyle(
//                         fontSize: 30,
//                       )),
//                 ),
//                 Lottie.asset('assets/car_and_user.json'),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: TextFormField(
//                     validator: (v) {
//                       if (v!.isEmpty) {
//                         return 'enter username';
//                       }
//                     },
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       label: Text('username'),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 if (!isLogin)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       validator: (v) {
//                         if (v!.isEmpty) {
//                           return 'enter name';
//                         }
//                       },
//                       controller: nameController,
//                       decoration: InputDecoration(
//                         label: Text('name'),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 if (!isLogin)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       validator: (v) {
//                         if (v!.isEmpty) {
//                           return 'location is not given';
//                         }
//                       },
//                       controller: locationController,
//                       decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                             onPressed: fetchLocation,
//                             icon: Icon(Icons.location_on)),
//                         label: Text('location'),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 if (!isLogin)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       maxLines: 4,
//                       validator: (v) {
//                         if (v!.isEmpty) {
//                           return 'enter address';
//                         }
//                       },
//                       controller: addressController,
//                       decoration: InputDecoration(
//                         label: Text('address'),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 if (!isLogin)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       validator: (v) {
//                         if (v!.isEmpty) {
//                           return 'enter phone';
//                         }
//                       },
//                       controller: phoneController,
//                       decoration: InputDecoration(
//                         label: Text('phone'),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 if (!isLogin)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       validator: (v) {
//                         if (v!.isEmpty) {
//                           return 'enter min wage';
//                         } else if (int.parse(v) < 1) {
//                           return 'enter minimum amount';
//                         }
//                       },
//                       controller: minWageController,
//                       decoration: InputDecoration(
//                         label: Text('min wage'),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: TextFormField(
//                     validator: (v) {
//                       if (v!.isEmpty) {
//                         return 'enter password';
//                       }
//                     },
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       label: Text('password'),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: ElevatedButton(
//                       onPressed: () {
//                         // Navigator.of(context).pushNamed(HomePage.routeName);
//                         isLogin ? null : signUp();
//                       },
//                       child: Text(isLogin ? 'Login' : 'SignUp')),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(
//                               context, LoginPage.routeName);
//                         },
//                         child: Text(
//                             isLogin ? 'SignUp instead?' : 'SignUp instead')),
//                     TextButton(
//                         onPressed: () {
//                           setState(() {
//                             isLogin = !isLogin;
//                           });
//                         },
//                         child: Text(
//                             isLogin ? 'SignUp instead?' : 'SignUp instead')),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
