import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/cat.dart';
import 'package:master_menu/model/repat.dart';
import 'package:master_menu/model/variant.dart';
import 'package:master_menu/screens/variant/item_variant.dart';

class CtrlDetail extends GetxController {
  WebServices ws = WebServices();
  TextEditingController tECTitleDetail = TextEditingController();
  TextEditingController tECPrix = TextEditingController();

  late Reposit reposit;
  int? selectedCat = -1;
  MVariant? selectedVariant;

  String state = "";
  MRepat repat =
      MRepat(id: -5, title: "", image: "", status: "", variants: [], catId: -1);
  int code = -1;
  List<MCat> listCat = [];
  List<DropdownMenuItem> items = [
    const DropdownMenuItem(value: -1, child: Text("Select your cat "))
  ];
  List<MVariant> listeVariant = [];
  List<DropdownMenuItem> itemsVariant = [
    DropdownMenuItem(
        value: MVariant(
          id: -22,
          title: "valeur initial",
          prix: 0,
          status: "1",
        ),
        child: Text("Select your variant "))
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    reposit = Reposit(ws);
    getlistCat();
  }

  Future getDetail(int id) async {
    await reposit.rep_getDetailRepat(id).then((value) => {
          print("detailll $value"),
          repat = MRepat.fromJson(value["detail"]),
          selectedCat = value["detail"]["categorie_id"],
          getlistVariant(),
          tECTitleDetail.text = repat.title,
          state = "3",
          update(),
        });
  }

  //**************************** */
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
      await reposit.rep_getCat(1, 10).then((value) => {
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
      await reposit.rep_getListeVariant(selectedCat!).then((value) => {
            code = -1,
            if (value["status"] == 1)
              {
                listeVariant = List.from(value["liste_variants"])
                    .map((e) => MVariant.fromJson(e))
                    .toList(),
                selectedVariant = null,
                itemsVariant = [],
                for (int i = 0; i < listeVariant.length; i++)
                  {
                    itemsVariant.add(DropdownMenuItem(
                        value: listeVariant[i],
                        child: Text(listeVariant[i].title)))
                  },
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
  Future<void> updateRepat() async {
    if (state == "") {
      state = "loading";
      update();
    }

    if (await CommFunc.checkInternet() == false) {
      state = "noInternet";
      update();
      CommFunc.showToast(content: "NoInternet".tr);
    } else {
      await reposit.rep_updateRepat(repat).then((value) => {
            code = -1,
            print("rresult update repatttt  ${value}"),
            /*     if (value["status"] == 1)
              {
                listeVariant = List.from(value["liste_variants"])
                    .map((e) => MVariant.fromJson(e))
                    .toList(),
                for (int i = 0; i < listeVariant.length; i++)
                  {
                    itemsVariant.add(DropdownMenuItem(
                        value: listeVariant[i],
                        child: Text(listeVariant[i].title)))
                  },
                state = "loaded",
                update(),
              }
        */
          });
    }

    // list_partner = ctrl_home.listPartner;
    //
    update();
  }

//****************************************** */
  void updateVariant() {
    int index = -1;
    for (int t = 0; t < repat.variants.length; t++) {
      if (repat.variants[t].id == selectedVariant!.id) {
        repat.variants[t].title = selectedVariant!.title;
        repat.variants[t].prix = int.parse(tECPrix.text);
        index = t;
      }
    }
    if (index == -1) {
      repat.variants.add(MVariant(
          id: selectedVariant!.id,
          title: selectedVariant!.title,
          prix: int.parse(tECPrix.text),
          status: "1"));
    }

    update();
  }

  //************************************************** */
  deleteRepatVariant(int id) {
    reposit.repDeleteRepatUnite(id).then(
          (value) => {
            if (value["status"] == 1)
              CommFunc.showToast(content: "Variant supprimé avec succés")
          },
        );
    repat.variants.removeWhere((element) => element.id == id);
    update();
  }

  //************************************************** */
  storeRepatVariant(int unite, int repat) {
    if (tECPrix.text.isEmpty) {
      CommFunc.showToast(content: "Montant vide non autorisé");
    }

    // else if(tryparse){}

    else {
      reposit.repStoreRepatUnite(unite, repat, int.parse(tECPrix.text)).then(
            (value) => {
              if (value["status"] == 1)
                CommFunc.showToast(content: "Variant Ajouté avec succés"),
              CommFunc.showToast(content: "Variant inséré avec succés"),
              tECPrix.text = "",
              update(),
              Get.back(),
              getDetail(repat),
            },
          );
    }

    update();
  }

  //************************************************** */
  updateRepatVariant(
    String status,
    int idRepatVariant,
  ) {
    reposit
        .repUpdateRepatVariant(status, idRepatVariant, int.parse(tECPrix.text))
        .then(
          (value) => {
            if (value["status"] == 1)
              CommFunc.showToast(content: "Variant Modifié avec succés"),
            tECPrix.text = "",
            update(),
            Get.back(),
            getDetail(repat.id),
          },
        );

    update();
  }
}
