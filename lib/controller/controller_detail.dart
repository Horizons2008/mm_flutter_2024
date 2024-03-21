import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/cat.dart';
import 'package:master_menu/model/repat.dart';
import 'package:master_menu/model/variant.dart';

class CtrlDetail extends GetxController {
  WebServices ws = WebServices();
  TextEditingController tECTitleDetail = TextEditingController();
  TextEditingController tECPrix = TextEditingController();

  late Reposit reposit;
  int? selectedCat = -1;
  MVariant? selectedVariant;
  List<int> deleted = [];

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
          idRepatVariant: -1,
          id: -22,
          title: "valeur initial",
          prix: 0,
          status: "1",
        ),
        child: Text("Select your variant "))
  ];
  @override
  void onInit() {
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
    CtrlCat ctrl = Get.put(CtrlCat());
    if (state == "") {
      state = "loading";
      update();
    }

    if (await CommFunc.checkInternet() == false) {
      state = "noInternet";
      update();
      CommFunc.showToast(content: "NoInternet".tr);
    } else {
      await reposit.repUpdateRepat(repat, deleted.toString()).then((value) => {
            code = -1,
            if (value["status"] == 1)
              {
                CommFunc.showToast(content: "Repat Modifié avec succées"),
                Get.back(),
                ctrl.getlisteRepat(),
              }
            /* {
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
          idRepatVariant: -1,
          id: selectedVariant!.id,
          title: selectedVariant!.title,
          prix: int.parse(tECPrix.text),
          status: "1"));
    }

    update();
  }

  //************************************************** */
  deleteRepatVariant(MVariant item) {
    if (item.idRepatVariant != -1) deleted.add(item.idRepatVariant);
    update();
/*reposit.repDeleteRepatUnite(item.id).then(
          (value) => {
            if (value["status"] == 1)
              CommFunc.showToast(content: "Variant supprimé avec succés")
          },
        );*/
    repat.variants.removeWhere((element) => element.id == item.id);
    update();
  }

  //************************************************** */
  storeRepatVariant(int unite, int idRepat) {
    if (tECPrix.text.isEmpty) {
      CommFunc.showToast(content: "Montant vide non autorisé");
    }

    // else if(tryparse){}

    else {
      bool exist = false;

      for (int j = 0; j < repat.variants.length; j++) {
        if (repat.variants[j].id == unite) {
          exist = true;
        }
      }
      if (exist) {
        CommFunc.showToast(content: "Variant existe choisit un Autre");
      } else {
        repat.variants.add(MVariant(
            idRepatVariant: -1,
            id: selectedVariant!.id,
            status: "1",
            prix: int.parse(tECPrix.text),
            title: selectedVariant!.title));
        update();
        CommFunc.showToast(content: "Variant ajouté avec succés");
        Get.back();
      }

      /*  reposit.repStoreRepatUnite(unite, idRepat, int.parse(tECPrix.text)).then(
            (value) => {
              if (value["status"] == 1)
                CommFunc.showToast(content: "Variant Ajouté avec succés"),
              tECPrix.text = "",
              update(),
              Get.back(),
              getDetail(idRepat),
            },
          );*/
    }

    update();
  }

  //************************************************** */
  updateRepatVariant(
    String status,
    MVariant item,
  ) {
    int index = repat.variants
        .indexWhere((element) => element.idRepatVariant == item.idRepatVariant);
    repat.variants[index].prix = int.parse(tECPrix.text);
    update();
    Get.back();

    /* reposit
        .repUpdateRepatVariant(status,item.idRepatVariant, int.parse(tECPrix.text))
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

    update();*/
  }
}
