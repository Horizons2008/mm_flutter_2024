import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_commande.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/entete.dart';
import 'package:master_menu/core/communFunctions.dart';
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
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade50,
            child: Column(
              children: [
                const Entete(),
                // ResumeCommande(tabl: tabl),
                const Expanded(child: ListV_Detail()),
                Container(
                  height: 60,
                  alignment: Alignment.centerRight,
                  child: CustomText(
                      text: "${CommFunc.ToMoney(val1.commande1.total)}",
                      size: 24,
                      weight: FontWeight.w600,
                      coul: black),
                ),
                (val1.commande1.detail.isEmpty)
                    ? CustomButton(titre: "desabled ", onclick: null)
                    : val1.status == "loading"
                        ? CustomButton(titre: "Traitement", onclick: () {})
                        : user1.role == "Serveur"
                            ? CustomButton(
                                titre: "Valider",
                                corner: 30,
                                onclick: () {
                                  CtrlCommande ctrlCommande =
                                      Get.put(CtrlCommande());
                                  ctrlCommande.storeCommande(tabl.id);
                                },
                              )
                            : CustomButton(
                                titre: "Encaissier",
                                corner: 30,
                                onclick: () {
                                  val1.enCaissement();
                                },
                              )
              ],
            ),
          );
        }),
      ),
    );
  }
}
