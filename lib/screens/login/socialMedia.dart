import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialMedia1 extends StatelessWidget {
  const SocialMedia1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              /*
              String mail = await Authenth.signInWithGmail();
              Ctrl_login ctrl_login = Get.find();
              ctrl_login.gmail = mail;
              ctrl_login.update();
              ctrl_login.checkLogin("", "", "", "", "");*/
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(6),
              width: 43,
              height: 43,
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
              FacebookAuth.instance.login();

              //  Authenth.signInWithFacebook();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 43,
              height: 43,
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
