import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/controller/controller_detail.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/repat.dart';
import 'package:master_menu/screens/details/screen_details.dart';

class ItemRepat extends StatelessWidget {
  const ItemRepat({super.key, required this.item, required this.index});
  final MRepat item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: PrimaryColor, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Colors.transparent,
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
                                text: item.title,
                                size: 16,
                                weight: FontWeight.w600,
                                coul: black),
                            CustomText(
                                text: "Nbr chaise: ${item.status}",
                                size: 12,
                                weight: FontWeight.w400,
                                coul: black),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                CtrlDetail ctrl = Get.put(CtrlDetail());    
    ctrl.getDetail(item.id);
                 showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
             

            return ScreenDetail(id: item.id);
          });
                
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              )),
          IconButton(
              onPressed: () {CtrlCat ctrlCat = Get.put(CtrlCat());
                ctrlCat.deleteRepat(item.id);},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
