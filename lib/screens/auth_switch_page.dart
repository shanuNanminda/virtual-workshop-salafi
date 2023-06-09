import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_workshop/screens/mechanic_auth_page.dart';
import 'package:virtual_workshop/screens/user_auth_page.dart';

class AuthSwitchPage extends StatelessWidget {
  AuthSwitchPage({super.key});

  List<Map<String, String>> lottieList = [
    {'name': 'Mechanic', 'lottie': 'assets/car_and_user.json'},
    {'name': 'User', 'lottie': 'assets/user.json'},
  ];
  CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    'CallMech',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              // Expanded(child: Lottie.asset('assets/home_car.json')),

              const Text('Who do you want to Login as',
                  style: TextStyle(fontSize: 25)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...lottieList
                        .map((e) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  lottieList.indexOf(e) == 0
                                      ? WorkshopAuthPage.routeName
                                      : UserAuthPage.routeName,
                                );
                              },
                              child: Card(
                                child: SizedBox(
                                  width: (deviceWidth / 2) - 20,
                                  height: 220,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Lottie.asset(e['lottie']!,
                                              frameRate: FrameRate(240))),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          e['name']!,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList()
                    // CarouselSlider(
                    //     items: lottieList.map((e) => Lottie.asset(e)).toList(),
                    //     carouselController: _carouselController,
                    //     options: CarouselOptions(
                    //       onScrolled: (value) {
                    //         print(value!.round()%10);
                    //       },
                    //     ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
