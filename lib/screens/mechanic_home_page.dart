import 'package:flutter/material.dart';
import 'package:virtual_workshop/widgets/mechanic_drawer.dart';

class MechanicHomePage extends StatelessWidget {
  const MechanicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MechanicDrawer(),
    );
  }
}