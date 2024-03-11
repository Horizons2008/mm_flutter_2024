import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/table.dart';
import 'package:master_menu/screens/server/commande/screen_commande.dart';

class ItemTableServeur extends StatelessWidget {
  const ItemTableServeur({super.key, required this.item, required this.index});
  final MTable item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlTable>(builder: (vvb) {
      return InkWell(
        onTap: () => {Get.to(() => Cart(tabl: item))},
        child: Container(
          width: 200,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: CommFunc.ColorStatus(item.status),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60.h,
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: item.name,
                            size: 16,
                            weight: FontWeight.w600,
                            coul: white),
                        CustomText(
                            text: "Nbr chaise: ${item.nbr_chaise}",
                            size: 12,
                            weight: FontWeight.w400,
                            coul: white),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
