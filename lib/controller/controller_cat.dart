import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/cat.dart';
import 'package:master_menu/model/commande.dart';
import 'package:master_menu/model/repat.dart';

class CtrlCat extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;
  File? image;
  MCat selectedCat = MCat(id: -1, image: "", title: "", status: "");

  List<MCat> listCat = [];
  List<MRepat> listeRepat = [];
  int last_record = 0;
  int hintCat = 0;
  ScrollController scrollcontroller = ScrollController();
  int code = -1;
  String state = "";
  String status_cat = "";
  TextEditingController textEditContTitle = TextEditingController();
  TextEditingController textEditContNewReapt = TextEditingController();

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

  Future openGallery() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) image = File(img.path);

    update();
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
            print("get list Cat $value"),
            code = -1,
            if (value["status"] == 1)
              {
                listCat = List.from(value["liste_categories"])
                    .map((e) => MCat.fromJson(e))
                    .toList(),
                if (listCat.length > 0)
                  {
                    selectedCat = listCat[0],
                    getlisteRepat(),
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

//************************************************** */
  Future<void> storeCat() async {
    state = "loading";
    update();
    if (textEditContTitle.text.isEmpty) {
      state = "loaded";
      hintCat = 1;
      update();
    } else {
      reposit
          .repStoreCat(selectedCat.id, textEditContTitle.text, "1",
              image != null ? image!.path : "")
          .then(
            (value) => {
              print("cc1 $value"),
              state = "loaded",
              if (value["status"] == 1)
                {
                  CommFunc.showToast(content: "Categorie inseré avec succés"),
                  Get.back(),
                  getlistCat(),
                }
              else if (value["status"] == 2)
                {
                  CommFunc.showToast(content: "Nom categorie deja existe"),
                  hintCat = 3,
                  update(),
                }
            },
          );
    }
  }

  //************************************************** */
  Future<void> deleteCat() async {
    reposit.repDeleteCat(selectedCat.id).then(
          (value) => {
            print("result delete catt: $value"),
            if (value["status"] == 1)
              {
                CommFunc.showToast(content: "Categorie Supprimé  avec succés"),
                getlistCat(),
              }
          },
        );
  }

  //************************************************************ */
  Future<void> storeRepat() async {
    reposit
        .repStoreRepat(
          selectedCat.id,
          textEditContNewReapt.text,
        )
        .then(
          (value) => {
            if (value["status"] == "1")
              {
                textEditContNewReapt.text = "",
                update(),
                CommFunc.showToast(content: "Categorie inseré avec succés"),
                getlistCat(),
              }
          },
        );
  }

  //************************************************************ */
  Future<void> deleteRepat(int id) async {
    reposit
        .repDeleteRepat(
          id,
        )
        .then(
          (value) => {
            if (value["status"] == 1)
              {
                CommFunc.showToast(content: "Repat supprimé avec succés"),
                getlisteRepat(),
              }

            /*  if (value["status"] == "1")
              {
                CommFunc.showToast(content: "Categorie inseré avec succés"),
                Get.back(),
                getlistCat(),
              }*/
          },
        );
  }

  //*********************************************************** */
  Future checkInOrder() async {
    MCommande commande = reposit1.commande1;
    for (int i = 0; i < listeRepat.length; i++) {
      for (int j = 0; j < listeRepat[i].variants.length; j++) {
        var contain = commande.detail.where(
            (element) => element.idRepatUnite == listeRepat[i].variants[j].id);

        if (contain.isNotEmpty) {
          listeRepat[i].inOrder =
              "${contain.first.titleVariant} [${contain.first.qte}]";
          update();
        }
      }
    }
  }

  //************************************************************ */
  Future<void> getlisteRepat() async {
    debugPrint("7718 ${jsonEncode(reposit1.commande1)}");
    reposit
        .rep_getListeRepat(
          selectedCat.id,
        )
        .then(
          (value) => {
            if (value["status"] == 1)
              {
                debugPrint("771 $value"),
                listeRepat = List.from(value["liste_repats"])
                    .map((e) => MRepat.fromJson(e))
                    .toList(),
                state = "loaded",
                update(),
                checkInOrder(),
              }
          },
        );
  }
}
