import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.titre,
    required this.onclick,
  });
  final String titre;
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: PrimaryColor),
      child: ElevatedButton(
        onPressed: onclick,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledBackgroundColor: grey3,
          backgroundColor: PrimaryColor,
        ),
        child: CustomText(
            text: titre, size: 18.sp, weight: FontWeight.w600, coul: white),
      ),
    );
  }
}
