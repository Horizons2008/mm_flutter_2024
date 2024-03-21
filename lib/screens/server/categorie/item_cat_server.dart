import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_hor.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/cat.dart';

class ItemCatServer extends StatelessWidget {
  const ItemCatServer({super.key, required this.item, required this.index});
  final MCat item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlCat>(builder: (val3) {
      return InkWell(
        onTap: () {
          val3.selectedCat = item;
          val3.getlisteRepat();
          val3.update();
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 80),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                // border: Border.all(color: PrimaryColor, width: 1),
                color: val3.selectedCat == item
                    ? PrimaryColor
                    : PrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  margin: EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
                SpaceH(w: 5),
                CustomText(
                    text: item.title,
                    size: 14,
                    weight: FontWeight.w400,
                    coul: val3.selectedCat == item ? white : white),
              ],
            ),
          ),
        ),
      );
    });
  }
}
