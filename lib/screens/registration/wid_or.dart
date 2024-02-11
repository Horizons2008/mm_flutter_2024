import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_menu/core/constants.dart';

class Divide_Or extends StatelessWidget {
  const Divide_Or({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(),
        ),
        Text(
          "Or".tr,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16.sp, color: grey6, fontWeight: FontWeight.w500)),
        ),
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
