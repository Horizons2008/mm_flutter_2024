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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          //   Color(0x7F0FB4FF),
                          Color(0xFFb7175f),
                          Colors.white,

                          Color(0xFFb7175f)
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        // margin: EdgeInsets.only(top: 300),
                        width: 135,
                        height: 115,

                        child: Image.asset(
                          "assets/images/logo.png",
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
