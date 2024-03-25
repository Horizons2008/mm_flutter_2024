import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.titre,
    required this.onclick,
    this.corner,
  });
  final String titre;
  final VoidCallback? onclick;
  final double? corner;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onclick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(corner ?? 10)),
        disabledBackgroundColor: grey8,
        backgroundColor: PrimaryColor,
      ),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: CustomText(
            text: titre, size: 18.sp, weight: FontWeight.w600, coul: white),
      ),
    );
  }
}
