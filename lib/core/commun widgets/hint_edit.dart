import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';

class HintError extends StatelessWidget {
  const HintError({super.key, required this.ind});
  final int ind;
  @override
  Widget build(BuildContext context) {
    String text = "";
    if (ind == 1)
      text = "EmptyField".tr;
    else if (ind == 2)
      text = "short_field".tr;
    else if (ind == 3)
      text = "used".tr;
    else if (ind == 4)
      text = "username incorrect".tr;
    else if (ind == 5) text = "valeur incorrect".tr;

    if (ind != 0)
      return Container(
        width: double.infinity,
        height: 20,
        alignment: Alignment.centerLeft,
        child: CustomText(
            text: text, size: 14, coul: Colors.red, weight: FontWeight.w500),
      );
    else
      return SizedBox();
  }
}
