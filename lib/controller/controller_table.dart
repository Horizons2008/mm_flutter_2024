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
  bool status_table = false;
  List<MTable> list_tables = [];
  int last_record = 0;
  int hint = 0;
  int hint_chaise = 0;
  MTable SelectedTableId = MTable(
      id: -1,
      name: "",
      nbr_chaise: "0",
      status: "0",
      count_order: 0,
      montant: 0);
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
    if (int.tryParse(textEditContNbrChaise.text) == null) {
      hint_chaise = 5;
      update();
    } else if (textEditContNomTable.text.isEmpty) {
      hint = 1;
      update();
    } else {
      reposit
          .repSstoreTable(SelectedTableId.id, textEditContNomTable.text,
              int.parse(textEditContNbrChaise.text), status_table)
          .then(
            (value) => {
              SelectedTableId.id = -1,
              textEditContNomTable.text = "",
              textEditContNbrChaise.text = "0",
              print("zzz $value"),
              if (value["status"] == 1)
                {
                  CommFunc.showToast(content: "Table inserer avec succés"),
                  Get.back(),
                  getlistTable(),
                }
              else if (value["status"] == 2)
                {
                  hint = 3,
                  state = "loaded",
                  update(),
                }
            },
          );
    }
  }

  //**************************************** */
  Future<void> DestroyTable() async {
    reposit.repDestroyTable(SelectedTableId.id).then((value) => {
          print("delete table ${value}"),
          if (value["status"] == 1)
            {
              getlistTable(),
              CommFunc.showToast(content: "Table suprimé avec succées"),
            }
        });
  }
}
