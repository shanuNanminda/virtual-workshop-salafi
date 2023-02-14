import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_workshop/screens/user_home_page.dart';
import 'package:virtual_workshop/services/http_services.dart';

import 'mechanic_auth_page.dart';

class UserAuthPage extends StatefulWidget {
  UserAuthPage({super.key});
  static String routeName = 'UserAuthPage';
  @override
  State<UserAuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<UserAuthPage> {
  bool isLogin = false;
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  signUp() async {
    if (formkey.currentState!.validate()) {
      print('sending');
      // Response res=await post(Uri.parse('http://192.168.68.167:8000/user_registration'));
      // print(res.body);
      final data = await HttpServices.postData(
        params: {
          'username': usernameController.text,
          'user_name': nameController.text,
          'password1': passwordController.text,
          'password2': passwordController.text,
          'address': addressController.text,
          'phone_number': phoneController.text,
        },
        endPoint: 'user_registration',
      );
      print(data);
      if (data['result']) {
        Navigator.pushNamed(context, UserHomePage.routeName);
      }
    }
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
                Padding(
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
                        signUp();
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
