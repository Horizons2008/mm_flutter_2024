import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class ApBar extends StatelessWidget {
  const ApBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      child: Row(
        children: [
          InkWell(
            /* Ctrl_dashboard ctrl = Get.find();
            ctrl.currentIndex = 0;
            ctrl.update();
            Get.to(Dashboard());*/

            child: Container(
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(35)),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: CustomText(
                text: title,
                size: 24,
                coul: grey3,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
