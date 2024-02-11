import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/cat.dart';
import 'package:master_menu/model/variant.dart';

class CtrlVariant extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;
  int selectedCat = -1;
  List<MCat> listCat = [];
  List<MVariant> listeVariant = [];
  List<DropdownMenuItem> items = [
    const DropdownMenuItem(value: -1, child: Text("Select your cat "))
  ];
  int last_record = 0;
  ScrollController scrollcontroller = ScrollController();
  int code = -1;
  String state = "";
  String status_cat = "";
  TextEditingController textEditContVariant = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    reposit = Reposit(ws);
    scrollcontroller = ScrollController()..addListener(pagination);
    getlistCat();
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
      getlistCat();
    } else {}
  }

  //********************************************** */
  Future<void> getlistCat() async {
    if (state == "") {
      state = "loading";
      update();
    }

    if (await CommFunc.checkInternet() == false) {
      state = "noInternet";
      update();
      CommFunc.showToast(content: "NoInternet".tr);
    } else {
      await reposit.rep_getCat(last_record, 10).then((value) => {
            code = -1,
            if (value["status"] == 1)
              {
                listCat = List.from(value["liste_categories"])
                    .map((e) => MCat.fromJson(e))
                    .toList(),
                for (int i = 0; i < listCat.length; i++)
                  items.add(DropdownMenuItem(
                    value: listCat[i].id,
                    child: Text(listCat[i].title),
                  )),
                state = "loaded",
                update(),
              }
          });
    }

    // list_partner = ctrl_home.listPartner;
    //
    update();
  }

//********************************************** */
  Future<void> getlistVariant() async {
    if (state == "") {
      state = "loading";
      update();
    }

    if (await CommFunc.checkInternet() == false) {
      state = "noInternet";
      update();
      CommFunc.showToast(content: "NoInternet".tr);
    } else {
      await reposit.rep_getListeVariant(selectedCat).then((value) => {
            code = -1,
            print("get liste variant ${value}"),
            if (value["status"] == 1)
              {
                listeVariant = List.from(value["liste_variants"])
                    .map((e) => MVariant.fromJson(e))
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
  Future<void> storeVariant() async {
    reposit
        .repStoreVariant(
          selectedCat,
          textEditContVariant.text,
        )
        .then(
          (value) => {
            print("store variant 116 $value"),
            if (value["status"] == "1")
              {
                CommFunc.showToast(content: "Categorie inseré avec succés"),
                textEditContVariant.text = "",
                update(),
                getlistVariant(),
              }
          },
        );
  }
}
