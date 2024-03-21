import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class BtnSm extends StatelessWidget {
  const BtnSm({
    super.key,
    required this.titre,
    required this.onclick,
  });
  final String titre;
  final VoidCallback? onclick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onclick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        disabledBackgroundColor: grey8,
        backgroundColor: PrimaryColor,
      ),
      child: CustomText(
          text: titre, size: 16.sp, weight: FontWeight.w600, coul: white),
    );
  }
}
