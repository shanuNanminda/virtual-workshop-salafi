import 'package:flutter/material.dart';

class TestFile extends StatelessWidget {
  TestFile({super.key});

  List<String> names = ['asdf', 'zxcv', 'qwer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text(
                names[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
