import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/commande.dart';
import 'package:master_menu/model/repat.dart';
import 'package:master_menu/model/variant.dart';

class CtrlCommande extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;
  MVariant selectedVariant = MVariant(id: -1, status: "1", prix: 0, title: "");
  MCommande commande1 = MCommande(id: -1, total: 0, date: "", detail: []);
  String status = "";
  List<int> listeDeleted = [];
  CtrlTable ctrlTable = Get.put(CtrlTable());
  MRepat repat =
      MRepat(id: -5, title: "", image: "", status: "", variants: [], catId: -1);
  MDetail temp = MDetail(
      id: -1,
      titleRepat: "",
      titleVariant: "",
      prixRepat: 0,
      qte: 0,
      sousTotal: 0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    reposit = Reposit(ws);
  }

  Future<void> deleteItem(int ind) async {
    commande1.total = commande1.total - commande1.detail[ind].sousTotal;

    if (commande1.detail[ind].id != -1) {
      listeDeleted.add(commande1.detail[ind].id);
    }
    commande1.detail.removeAt(ind);
    update();
  }

  Future<void> storeCommande(int tableId) async {
    status = "loading";
    update();

    await reposit
        .repStoreCommande(tableId, commande1, listeDeleted)
        .then((value) => {
              status = "loaded",
              update(),
              if (value['status'] == 1)
                {
                  CommFunc.showToast(
                      content: "Commande Enregistré avec succées"),
                  ctrlTable.getlistTable(),
                  update(),
                }
            });
  }

  Future<void> getCommande(int id) async {
    await reposit.rep_getCommandeByIdTable(id).then((value) => {
          debugPrint("result commande: $value"),
          if (value["commande"] != null)
            commande1 = MCommande.fromJson(value["commande"]),
        });
    update();
  }

  Future<void> deleteCommande() async {
    await reposit.repDeleteCommande(commande1.id).then((value) => {
          print("response delete ${value}"),
          commande1.detail = [],
          ctrlTable.getlistTable(),
          update(),
          update(),
        });
    update();
  }

  setSelectVariant(MVariant variant) {
    temp.titleVariant = variant.title;
    temp.prixRepat = variant.prix;

    temp.sousTotal = variant.prix * temp.qte;
    update();
  }

  updateQte(String oper) {
    if (oper == "+") {
      temp.qte++;
    } else if (oper == "-") {
      if (temp.qte > 1) {
        temp.qte--;
      }
    }
    temp.sousTotal = temp.prixRepat * temp.qte;

    update();
  }

  updateDetailCommande() {
    MDetail temp2 = temp;
    commande1.detail.add(MDetail(
        id: temp2.id,
        titleRepat: temp2.titleRepat,
        titleVariant: temp2.titleVariant,
        prixRepat: temp2.prixRepat,
        qte: temp2.qte,
        sousTotal: temp2.sousTotal));
    commande1.total = commande1.total + temp.sousTotal;
    update();
  }

  Future getDetail(int id) async {
    await reposit.rep_getDetailRepat(id).then((value) => {
          repat = MRepat.fromJson(value["detail"]),
          temp.titleRepat = repat.title,
          if (repat.variants.isNotEmpty)
            {
              selectedVariant = repat.variants[0],
              temp.titleVariant = repat.variants[0].title,
              temp.prixRepat = repat.variants[0].prix,
              temp.qte = 1,
              temp.sousTotal = repat.variants[0].prix,
            },
          /*  selectedCat = value["detail"]["cat_id"],
          getlistVariant(),
          tECTitleDetail.text = repat.title,
          state = "3",*/
          update(),
        });
  }
}
