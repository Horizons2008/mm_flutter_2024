import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_commande.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/commande.dart';
import 'package:master_menu/model/table.dart';

class ItemDetail extends StatelessWidget {
  ItemDetail({super.key, required this.item, required this.index});
  final MDetail item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlCommande>(builder: (ctrlVal) {
      return Container(
        width: 200,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "${item.titleRepat} ",
                              size: 16,
                              weight: FontWeight.w600,
                              coul: black),
                          CustomText(
                              text: " ${item.titleVariant}",
                              size: 14,
                              weight: FontWeight.w400,
                              coul: black),
                          CustomText(
                              text:
                                  " ${CommFunc.ToMoney(item.prixRepat)} * ${item.qte} ",
                              size: 12,
                              weight: FontWeight.w400,
                              coul: black),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () { ctrlVal.deleteItem(index);},
                            child: Icon(
                              CupertinoIcons.delete,
                              size: 15,
                              color: Colors.red,
                            ),
                          ),
                          //Spacer(),
                          CustomText(
                              text: "${CommFunc.ToMoney(item.sousTotal)}",
                              size: 20,
                              weight: FontWeight.w500,
                              coul: black),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
