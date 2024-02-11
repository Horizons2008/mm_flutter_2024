import 'package:get/get.dart';

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/user.dart';
import 'package:master_menu/model/table.dart';

class CtrlUser extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;
  int selectedRole = 2;
  List<MUser> listUsers = [];
  int last_record = 0;
  ScrollController scrollcontroller = ScrollController();
  int code = -1;
  String state = "";
  TextEditingController textEditContusername = TextEditingController();
  TextEditingController textEditContPass = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    reposit = Reposit(ws);
    scrollcontroller = ScrollController()..addListener(pagination);
    getlistUsers();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  //***************************************** */
  void pagination() async {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (state != "finished") &&
        (code == -1)) {
      code = 0;
      last_record = last_record + 10;
      state = "charging";
      update();
      getlistUsers();
    } else {}
  }

  //********************************************** */
  Future<void> getlistUsers() async {
    if (state == "") {
      state = "loading";
      update();
    }

    if (await CommFunc.checkInternet() == false) {
      state = "noInternet";
      update();
      CommFunc.showToast(content: "NoInternet".tr);
    } else {
      await reposit.rep_getUser(last_record, 10).then((value) => {
            print("get list users $value"),
            code = -1,
            if (value["status"] == 1)
              {
                print("mappped"),
                listUsers = List.from(value["liste_users"])
                    .map((e) => MUser.fromJson(e))
                    .toList(),
                state = "loaded",
                update(),
              }
          });
    }

    // list_partner = ctrl_home.listPartner;
    //
    update();
  }

//************************************************** */
  Future<void> storeUser() async {
    reposit
        .repStoreUser(
            textEditContusername.text, textEditContPass.text, selectedRole)
        .then(
          (value) => {
            if (value["status"] == "1")
              {
                CommFunc.showToast(content: "Utilisateur inseré avec succés"),
                Get.back(),
                getlistUsers(),
              }
          },
        );
  }
}
