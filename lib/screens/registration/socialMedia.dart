import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              //   Authenth.signInWithGmail();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(6),
              width: 43.w,
              height: 43.w,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFF888888)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Image.asset("assets/images/logo_google.png"),
            ),
          ),
          InkWell(
            onTap: () {
              //   Authenth.signInWithFacebook();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 43.w,
              height: 43.w,
              padding: EdgeInsets.all(6),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF888888)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Image.asset("assets/images/logo_fb.png"),
            ),
          ),
        ],
      ),
    );
  }
}
