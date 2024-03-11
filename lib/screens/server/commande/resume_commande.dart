import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:master_menu/controller/controller_commande.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/table.dart';

class ResumeCommande extends StatelessWidget {
  const ResumeCommande({super.key, required this.tabl});
  final MTable tabl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlCommande>(builder: (val_ctrl) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: PrimaryColor, width: 0.8),
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Table: ${tabl.name}",
                size: 16,
                weight: FontWeight.w500,
                coul: black),
            CustomText(
                text: "Montant: ${val_ctrl.commande1.total}",
                size: 16,
                weight: FontWeight.w500,
                coul: black),
            CustomText(
                text: "Nbr repats: ${val_ctrl.commande1.detail.length}",
                size: 16,
                weight: FontWeight.w500,
                coul: black),
          ],
        ),
      );
    });
  }
}
