// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/screens/dashboard/screen_dashboard.dart';
import 'package:master_menu/screens/login/screenLogin.dart';
import 'package:master_menu/screens/server/home/screen_table.dart';

class Ctrl_Splash extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    final box = GetStorage();
    logged = await box.read("logged") ?? false;
    if (logged == true) {
      user1 = CommFunc.ReadSession();
     
    }

    Future.delayed(Duration(seconds: 1), () {
      logged
          ? {
              user1.role == "Serveur"
                  ? Get.offAll(DashboardServer())
                  : Get.offAll(Dashboard())
            }
          : Get.offAll(ScreenLogin());
    });
  }

  WebServices ws = WebServices();
  late Reposit reposit;
  dynamic decod;
  int ExistUpdate = -1;
  int requiredUpdate = 0;
  int current_version = 0;

  double lat = 0, lng = 0, zoom = 0;
  final box = GetStorage();

/*
  CameraPosition DefaultPosition = const CameraPosition(
    target: LatLng(36.345986, 3.222663),
    zoom: 10,
  );*/

  Future<void> getConfig() async {
    /*
    final box = GetStorage();
    reposit = Reposit(ws);
    await reposit.rep_getConfig().then((value) => {
          print("init config $value"),
          decod = value["app_c_default_position"],
          lat = double.parse(jsonDecode(decod)["lat"]),
          lng = double.parse(jsonDecode(decod)["lng"]),
          zoom = double.parse(jsonDecode(decod)["zoom"]),
          //   DefaultPosition =
          //       CameraPosition(target: LatLng(lat, lng), zoom: zoom),

          box.write('initLat', jsonDecode(decod)["lat"]),
          box.write('initLng', jsonDecode(decod)["lng"]),
          box.write('initzoom', jsonDecode(decod)["zoom"]),

          update(),
        });
    bool islogin = box.read("isLogin") ?? false;
    if (islogin == false) {
      String deviceId = box.read("deviceId") ?? "";
      if (deviceId == "") {
        var deviceInfo = DeviceInfoPlugin();

        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      }

      print("device id 11111111111111111111 ${deviceId}");

      box.write('DeviceId', deviceId);
      await Checklogin(deviceId);
    }*/
  }
}
