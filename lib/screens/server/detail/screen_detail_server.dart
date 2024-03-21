import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_commande.dart';
import 'package:master_menu/core/commun%20widgets/btn_sm.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/server/detail/panel_qte.dart';

class DetailRepatServer extends StatelessWidget {
  const DetailRepatServer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*  appBar: AppBar(
          title: const CustomText(
              text: "مرحبا بكم ",
              size: 22,
              weight: FontWeight.bold,
              coul: Colors.red),
        ),*/
        body: GetBuilder<CtrlCommande>(builder: (val1) {
      return Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*   Container(
                width: double.infinity,
                height: 180,
                color: Colors.amber,
                child: Image.asset(
                  "assets/images/image_not_found.jpg",
                  fit: BoxFit.fill,
                )),
            const SpaceV(h: 40),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: val1.repat.title,
                    size: 22,
                    weight: FontWeight.w600,
                    coul: black),
                const PanelQte()
              ],
            ),
            const SpaceV(h: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  itemCount: val1.repat.variants.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        val1.selectedVariant = val1.repat.variants[index];
                        val1.setSelectVariant(val1.repat.variants[index]);
                        val1.update();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: val1.repat.variants[index].id ==
                                    val1.selectedVariant.id
                                ? Colors.amber.shade100
                                : Colors.white,
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomText(
                                text: val1.repat.variants[index].title,
                                size: 14,
                                weight: FontWeight.w400,
                                coul: black),
                            CustomText(
                                text:
                                    "${CommFunc.ToMoney(val1.repat.variants[index].prix)}",
                                size: 12,
                                weight: FontWeight.w400,
                                coul: black),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SpaceV(h: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Total ${val1.temp.sousTotal}",
                    size: 18,
                    weight: FontWeight.w600,
                    coul: black),
                BtnSm(
                    titre: "Ajouter",
                    onclick: () {
                      val1.updateDetailCommande();
                      Get.back();
                    })
              ],
            ),
          ],
        ),
      );
    }));
  }
}
