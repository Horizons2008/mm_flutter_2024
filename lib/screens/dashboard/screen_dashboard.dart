import 'package:flutter/material.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/dashboard/drawer_menu.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "My restaurant",
            size: 22,
            weight: FontWeight.w600,
            coul: black),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CustomText(
                text: "Dashboard page",
                size: 16,
                weight: FontWeight.bold,
                coul: black),
          )),
    );
  }
}
