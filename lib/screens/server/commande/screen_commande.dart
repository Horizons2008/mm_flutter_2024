import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_commande.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/table.dart';
import 'package:master_menu/screens/server/categorie/screen_cat_serveur.dart';
import 'package:master_menu/screens/server/commande/listv_detail.dart';
import 'package:master_menu/screens/server/commande/resume_commande.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
    required this.tabl,
  });
  final MTable tabl;

  @override
  Widget build(BuildContext context) {
    CtrlCommande ctrlCommande = Get.put(CtrlCommande());
    ctrlCommande.getCommande(tabl.id);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: tabl.name, size: 18, weight: FontWeight.w500, coul: black),
        actions: [
          const CircleAvatar(
            child: Icon(
              Icons.print,
              color: PrimaryColor,
              size: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CircleAvatar(
              child: InkWell(
                onTap: () {
                  ctrlCommande.deleteCommande();
                },
                child: Icon(
                  Icons.delete_sharp,
                  color: PrimaryColor,
                  size: 20,
                ),
              ),
            ),
          ),
          CircleAvatar(
            child: InkWell(
              onTap: () {
                Get.to(() => ScreenCatServer());
              },
              child: Icon(
                Icons.add_shopping_cart,
                color: PrimaryColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: GetBuilder<CtrlCommande>(builder: (val1) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade50,
            child: Column(
              children: [
                ResumeCommande(tabl: tabl),
                Expanded(child: ListV_Detail()),
                (val1.commande1.detail.length == 0)
                    ? CustomButton(titre: "desabled ", onclick: null)
                    : val1.status == "loading"
                        ? CustomButton(titre: "Traitement", onclick: () {})
                        : CustomButton(
                            titre: "Valider",
                            onclick: () {
                              CtrlCommande ctrlCommande =
                                  Get.put(CtrlCommande());
                              ctrlCommande.storeCommande(tabl.id);
                            })
              ],
            ),
          );
        }),
      ),
    );
  }
}
