import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class PleaseWait extends StatelessWidget {
  const PleaseWait({super.key, required this.cont});
  final BuildContext cont;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      surfaceTintColor: white,
      elevation: 15,
      child: Container(
        width: MediaQuery.of(cont).size.width - 40,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 25.w,
              height: 25.h,
              child: const CircularProgressIndicator(
                color: PrimaryColor,
              ),
            ),
            CustomText(
                text: "downloading".tr,
                size: 16,
                weight: FontWeight.normal,
                coul: grey3)
          ],
        ),
      ),
    );
  }
}
