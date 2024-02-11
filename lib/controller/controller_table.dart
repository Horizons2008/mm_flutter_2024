import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/table.dart';

class CtrlTable extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;
  List<MTable> list_tables = [];
  int last_record = 0;
  ScrollController scrollcontroller = ScrollController();
  int code = -1;
  String state = "";
  TextEditingController textEditContNomTable = TextEditingController();
  TextEditingController textEditContNbrChaise = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    reposit = Reposit(ws);
    scrollcontroller = ScrollController()..addListener(pagination);
    getlistTable();
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
      getlistTable();
    } else {}
  }

  //********************************************** */
  Future<void> getlistTable() async {
    if (state == "") {
      state = "loading";
      update();
    }

    
    if (await CommFunc.checkInternet() == false) {
      state = "noInternet";
      update();
      CommFunc.showToast(content: "NoInternet".tr);
    } else {
      await reposit.rep_getTable(last_record, 10).then((value) => {
            print("get list table $value"),
            code = -1,
            if (value["status"] == 1)
              {
                list_tables = List.from(value["liste_tables"])
                    .map((e) => MTable.fromJson(e))
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
  Future<void> storeTable() async {
    reposit
        .repSstoreTable(
            textEditContNomTable.text, int.parse(textEditContNbrChaise.text))
        .then(
          (value) => {
            print("1447 $value"),
            if (value["status"] == "1")
              {
                print("1447 succed"),
                CommFunc.showToast(content: "Table inserer avec succés"),
                Get.back(),
                getlistTable(),
              }
          },
        );
  }
}
