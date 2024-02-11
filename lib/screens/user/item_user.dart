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
    return GetBuilder<CtrlUser>(
        init: CtrlUser(),
        builder: (vvb) {
          return Container(
            width: 200,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 60.h,
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: item.username,
                                  size: 16,
                                  weight: FontWeight.w600,
                                  coul: white),
                              CustomText(
                                  text: "Nbr chaise: ${item.role}",
                                  size: 12,
                                  weight: FontWeight.w400,
                                  coul: white),
                            ],
                          ),
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
