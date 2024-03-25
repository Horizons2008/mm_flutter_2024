import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/commande.dart';
import 'package:master_menu/model/repat.dart';
import 'package:master_menu/model/variant.dart';

class CtrlCommande extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;
  MVariant selectedVariant =
      MVariant(idRepatVariant: -1, id: -1, status: "1", prix: 0, title: "");
  MCommande commande1 = MCommande(id: -1, total: 0, date: "", detail: []);
  String status = "";
  bool loading = false;
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
      sousTotal: 0,
      idRepatUnite: 0);

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
    if (await reposit1.rep_getCommandeByIdTable(id) != null) {
      commande1 = reposit1.commande1;

      update();
    }

    /* await reposit.rep_getCommandeByIdTable(id).then((value) => {
          debugPrint("result commande: $value"),
          if (value["commande"] != null)
            commande1 = MCommande.fromJson(value["commande"]),
        });
    update();*/
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
    temp.idRepatUnite = variant.idRepatVariant;

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

  Future enCaissement() async {
    CtrlTable ctrl = Get.find();
    await reposit1
        .repEncaissementCommande(reposit1.commande1.id)
        .then((value) => {
              if (value["status"] == 1)
                {
                  CommFunc.showToast(
                      content: "Encaissement effectué avec succés"),
                  ctrl.getlistTable(),
                  Get.back(),
                }
            });
  }

  //-------------------------------------------------------------
  updateDetailCommande() {
    MDetail temp2 = temp;
    // debugPrint("1190 ${jsonEncode(temp2)} ");
    // debugPrint("119055 ${jsonEncode(commande1)} ");

    var contain = commande1.detail
        .where((element) => element.idRepatUnite == temp2.idRepatUnite);
    if (contain.isEmpty) {
      commande1.detail.add(MDetail(
        id: temp2.id,
        titleRepat: temp2.titleRepat,
        titleVariant: temp2.titleVariant,
        prixRepat: temp2.prixRepat,
        qte: temp2.qte,
        sousTotal: temp2.sousTotal,
        idRepatUnite: temp2.idRepatUnite,
      ));
      commande1.total = commande1.total + temp.sousTotal;
      update();
      CtrlCat controller = Get.find();
      controller.checkInOrder();
    } else {
      commande1.total = commande1.total - contain.first.sousTotal;
      contain.first.qte = temp2.qte;
      contain.first.sousTotal = temp2.qte * temp2.prixRepat;
      commande1.total = commande1.total + contain.first.sousTotal;

      update();
    }
  }

  Future getDetail(int id) async {
    loading = true;
    update();
    await reposit.rep_getDetailRepat(id).then((value) => {
          loading = false,
          repat = MRepat.fromJson(value["detail"]),
          temp.titleRepat = repat.title,
          if (repat.variants.isNotEmpty)
            {
              selectedVariant = repat.variants[0],
              temp.titleVariant = repat.variants[0].title,
              temp.prixRepat = repat.variants[0].prix,
              temp.qte = 1,
              temp.sousTotal = repat.variants[0].prix,
              temp.idRepatUnite = repat.variants[0].idRepatVariant,
            },
          /*  selectedCat = value["detail"]["cat_id"],
          getlistVariant(),
          tECTitleDetail.text = repat.title,
          state = "3",*/
          update(),
        });
  }
}
