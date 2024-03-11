import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_commande.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class PanelQte extends StatelessWidget {
  const PanelQte({super.key});

  @override
  Widget build(BuildContext context) {
    double size = 40;
    return GetBuilder<CtrlCommande>(builder: (ctrlVal) {
      return Row(
        children: [
          InkWell(
            onTap: () {
              ctrlVal.updateQte("-");
            },
            child: Container(
              alignment: Alignment.center,
              width: size,
              height: size,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: PrimaryColor),
              child: CustomText(
                  text: "-", size: 26, weight: FontWeight.w600, coul: white),
            ),
          ),
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                color: white),
            child: CustomText(
                text: "${ctrlVal.temp.qte}",
                size: 22,
                weight: FontWeight.w600,
                coul: PrimaryColor),
          ),
          InkWell(
            onTap: () {
              ctrlVal.updateQte("+");
            },
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: PrimaryColor),
              child: CustomText(
                  text: "+", size: 22, weight: FontWeight.w600, coul: white),
            ),
          ),
        ],
      );
    });
  }
}
