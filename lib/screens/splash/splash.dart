import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:master_menu/controller/controller_splash.dart';
import 'package:url_launcher/url_launcher.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Ctrl_Splash>(
          init: Ctrl_Splash(),
          builder: (v1) {
            return Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Center(
                      child: Container(
                        // margin: EdgeInsets.only(top: 300),
                        width: 320,
                        height: 320,

                        child: Image.asset(
                          "assets/images/Animation.gif",
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
              ],
            );
          }),
    );
  }
}
