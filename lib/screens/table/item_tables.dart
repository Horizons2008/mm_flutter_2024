import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/table.dart';

class ItemTable extends StatelessWidget {
  ItemTable({super.key, required this.item, required this.index});
  final MTable item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlTable>(builder: (vvb) {
      return Material(
        surfaceTintColor: Colors.transparent,
        child: InkWell(
          onTap: () {
            vvb.SelectedTableId = item;
            vvb.update();
          },
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: item == vvb.SelectedTableId ? grey8 : white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    CustomText(
                        text: "  ${CommFunc.LabelStatus(item.status)}  ",
                        size: 12,
                        weight: FontWeight.w500,
                        coul: CommFunc.ColorStatus(item.status)),
                    SizedBox(
                      width: 10,
                      height: 10,
                      child: CircleAvatar(
                        backgroundColor: CommFunc.ColorStatus(item.status),
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: item.name,
                  size: 16,
                  weight: FontWeight.w600,
                  coul: item.id == vvb.SelectedTableId ? white : black,
                ),
                CustomText(
                    text: item.montant != 0
                        ? "Total : ${CommFunc.ToMoney(item.montant)} "
                        : "",
                    size: 14,
                    weight: FontWeight.w400,
                    coul: black),
              ],
            ),
          ),
        ),
      );
    });
  }
}
