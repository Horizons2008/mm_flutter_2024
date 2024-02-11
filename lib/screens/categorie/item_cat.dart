import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/cat.dart';

class ItemCat extends StatelessWidget {
  const ItemCat({super.key, required this.item, required this.index});
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
        child: Container(
          width: 100,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              border: Border.all(color: PrimaryColor, width: 1),
              color: val3.selectedCat == item ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: item.title,
                  size: 16,
                  weight: FontWeight.w600,
                  coul: black),
              CustomText(
                  text: " ${item.status}",
                  size: 12,
                  weight: FontWeight.w400,
                  coul: black),
            ],
          ),
        ),
      );
    });
  }
}
