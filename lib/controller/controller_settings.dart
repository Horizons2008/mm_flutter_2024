import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/screens/login/screenLogin.dart';

class CtrlSettings extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    reposit = Reposit(ws);
  }

  Future<void> logOut() async {
    await reposit.rep_logout().then((value) => {
          debugPrint("response logout $value"),
          if(value['status']==1)
          {CommFunc.closeSession(),
          
          Get.offAll(()=>ScreenLogin())}
        });
  }
}
