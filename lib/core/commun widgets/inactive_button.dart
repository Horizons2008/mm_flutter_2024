import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class InactiveButton extends StatelessWidget {
  const InactiveButton({
    super.key,
    required this.titre,
   
  });
  final String titre;
 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: PrimaryColor),
      child: ElevatedButton(
        onPressed:(){} ,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledBackgroundColor: grey3,
          backgroundColor:Colors.grey ,
        ),
        child: CustomText(
            text: titre, size: 18.sp, weight: FontWeight.w600, coul: white),
      ),
    );
  }
}
