import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/cat.dart';

class ItemVariant extends StatelessWidget {
  const ItemVariant({super.key, required this.item, required this.index});
  final  item;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                            text: item.title,
                            size: 16,
                            weight: FontWeight.w600,
                            coul: white),
                        CustomText(
                            text: "Nbr chaise: ${item.status}",
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
  }
}
