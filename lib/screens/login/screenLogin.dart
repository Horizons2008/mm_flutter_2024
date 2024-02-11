import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_menu/controller/controller_login.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/hint_edit.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/login/socialMedia.dart';
import 'package:master_menu/screens/login/wid_or.dart';
import 'package:master_menu/screens/registration/screenRegistration.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Ctrl_login ctrl_login = Get.put(Ctrl_login());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                //  CommunAppBar("", 1),
                SpaceV(h: 30.h),
                SizedBox(
                  width: 117.w,
                  height: 100.h,
                  child: Image.asset("assets/images/logo.png"),
                ),
                SpaceV(h: 24.h),
                Container(
                  child: CustomText(
                      text: 'welcome'.tr,
                      size: 20,
                      weight: FontWeight.w600,
                      coul: grey6),
                ),
                SpaceV(h: 32.h),
                CustomEdit(
                    hint: "Username",
                    onChange: (val) {
                      ctrl_login.setUsername(val);
                    }),
                GetBuilder<Ctrl_login>(builder: (vv) {
                  return HintError(ind: vv.hint_user);
                }),
                SpaceV(h: 40),
                CustomEdit(
                    hint: "Password",
                    onChange: (val) {
                      ctrl_login.setPassword(val);
                    }),
                GetBuilder<Ctrl_login>(builder: (vv) {
                  return HintError(ind: vv.hint_pass);
                }),

                /*  customEdit(
                    "Username".tr,
                    Image.asset("assets/images/mail.png"),
                    (val) {
                      ctrl_login.setUsername(val);
                    },
                    2,
                    "txt",
                    (ch) {
                      return null;
                    },
                    null),*/
                SpaceV(h: 24),
                /*  customEdit(
                    "Password".tr, Image.asset("assets/images/icone_lock.png"),
                    (val) {
                  ctrl_login.setPassword(val);
                }, 2, "pass", null, null),*/
                Row(
                  children: [
                    GetBuilder<Ctrl_login>(builder: (cont) {
                      return Checkbox(
                        activeColor: PrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(width: 0.7, color: grey8),

                        checkColor: Colors.white,
                        //  fillColor:Color.fromARGB(255, 175, 146, 60),
                        value: cont.savePassword,
                        onChanged: (bool? value) {
                          cont.changeSavePassword();
                        },
                      );
                    }),
                    CustomText(
                        text: "Rememberme".tr,
                        size: 14.sp,
                        weight: FontWeight.w400,
                        coul: grey8),
                    const Spacer(),
                    /*  InkWell(
                      onTap: () {
                        Get.to(const ForgetPassword());
                      },
                      // child: customText("forgetPas".tr, 14, grey8, FontWeight.w400)
                    ),*/
                  ],
                ),
                SpaceV(h: 32),
                GetBuilder<Ctrl_login>(builder: (vv1) {
                  double h = 60.h;
                  double w = 300.w;
                  double r = 10;
                  Widget element = CustomText(
                      text: "Connect2".tr,
                      size: 18.sp,
                      weight: FontWeight.w600,
                      coul: white);

                  if (vv1.state_login == "loading") {
                    h = 60.h;
                    w = 60.w;
                    r = 40;
                    element = CircularProgressIndicator(
                      color: white,
                      strokeWidth: 5,
                    );
                  } else if (vv1.state_login == "logged") {
                    h = 60.h;
                    w = 60.w;
                    r = 40;
                    element = Icon(Icons.done, size: 40, color: white);
                  } else {
                    h = 60;
                    w = 300;
                    r = 10;
                    element = CustomText(
                        text: "Connect2".tr,
                        size: 18.sp,
                        weight: FontWeight.w600,
                        coul: white);
                  }

                  return InkWell(
                    onTap: () {
                      ctrl_login.checkLogin("user", "", "", "", "");
                    },
                    child: AnimatedContainer(
                      width: w,
                      height: h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(r),
                          color: PrimaryColor),
                      duration: Duration(milliseconds: 300),
                      child: element,
                    ),
                  );
                  /*  return vv1.state_login == "loading"
                      ? loadingButton("Connect2".tr)
                      : customButton("Connect2".tr, () {
                          ctrl_login.checkLogin("user", "", "", "", "");
                        });
             */
                }),
                SpaceV(h: 30),
                const Divide_Or(),
                SpaceV(h: 30),
                const SocialMedia1(),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "haventCompte".tr,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: grey8))),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(const ScreenRegistration()),
                        text: "CreateCompte".tr,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: PrimaryColor)))
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
