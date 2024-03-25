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
        height: 100,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 40),
              // padding: EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Card(
                surfaceTintColor: white,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Column(
                    children: [
                      Container(
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        ctrlVal.deleteItem(index);
                                      },
                                      child: Icon(
                                        CupertinoIcons.delete,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                    //Spacer(),
                                    CustomText(
                                        text:
                                            "${CommFunc.ToMoney(item.sousTotal)}",
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
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/12.png")),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.amber),
            )
          ],
        ),
      );
    });
  }
}
