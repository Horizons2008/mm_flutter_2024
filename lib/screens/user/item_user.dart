import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/controller/controller_user.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/user.dart';

class ItemUser extends StatelessWidget {
  const ItemUser({super.key, required this.item, required this.index});
  final MUser item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlUser>(builder: (c1) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            c1.selectedUser = item;
            c1.update();
          },
          child: Container(
            width: double.infinity,
            height: 80.h,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: black),
              color:
                  item == c1.selectedUser ? Colors.grey.shade200 : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    child: CustomText(
                        text: item.username.substring(0, 1).toUpperCase(),
                        size: 28,
                        weight: FontWeight.w400,
                        coul: black),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: item.username,
                        size: 16,
                        weight: FontWeight.w600,
                        coul: black),
                    CustomText(
                        text: " ${item.role}",
                        size: 12,
                        weight: FontWeight.w400,
                        coul: black),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
