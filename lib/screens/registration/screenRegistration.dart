import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_menu/controller/controller_registration.dart';
import 'package:master_menu/core/commun%20widgets/apbar.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/hint_edit.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/login/wid_or.dart';
import 'package:master_menu/screens/registration/socialMedia.dart';

class ScreenRegistration extends StatelessWidget {
  const ScreenRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    Ctrl_Regis ctrlRegis = Get.put(Ctrl_Regis());
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                ApBar(
                  title: "",
                ),
                SpaceV(h: 10.h),
                SizedBox(
                  width: 117.w,
                  height: 100.h,
                  child: Image.asset("assets/images/logo.png"),
                ),
                SpaceV(h: 20),
                Container(
                  child: CustomText(
                      text: "CreateCompte".tr,
                      size: 20.sp,
                      coul: const Color(0xFF333333),
                      weight: FontWeight.w600),
                ),
                SpaceV(h: 42.h),
                CustomEdit(
                  hint: "nom restaurant".tr,
                  //Image.asset("assets/images/icone_person.png"),
                  onChange: (val) {
                    ctrlRegis.setRestName(val);
                  },
                ),
                GetBuilder<Ctrl_Regis>(builder: (v) {
                  return HintError(ind: v.hintRest);
                }),
                SpaceV(h: 16.h),
                CustomEdit(
                  hint: "Username".tr,
                  //Image.asset("assets/images/icone_lock.png"),
                  onChange: (val) {
                    ctrlRegis.setUsername(val);
                  },
                ),
                GetBuilder<Ctrl_Regis>(builder: (v) {
                  return HintError(ind: v.hintUser);
                }),
                SpaceV(h: 16.h),
                CustomEdit(
                  hint: "Password".tr,
                  //Image.asset("assets/images/icone_lock.png"),
                  onChange: (val) {
                    ctrlRegis.setPass(val);
                  },
                ),
                GetBuilder<Ctrl_Regis>(builder: (v) {
                  return HintError(ind: v.hintPass);
                }),
                SpaceV(h: 22),
                GetBuilder<Ctrl_Regis>(builder: (vv1) {
                  double h = 60.h;
                  double w = 300.w;
                  double r = 10;
                  Widget element = CustomText(
                      text: "Connect2".tr,
                      size: 18.sp,
                      weight: FontWeight.w600,
                      coul: white);

                  if (vv1.state == "loading") {
                    h = 60.h;
                    w = 60.w;
                    r = 40;
                    element = CircularProgressIndicator(
                      color: white,
                      strokeWidth: 5,
                    );
                  } else if (vv1.state == "logged") {
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
                      ctrlRegis.saveRegis();
                      //ctrlRegis.checkLogin("user", "", "", "", "");
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
                SpaceV(h: 32.h),
                const Divide_Or(),
                SizedBox(
                  height: 10.h,
                ),
                deviceType == "android"
                    ? const SocialMedia()
                    : const SizedBox(),
                SpaceV(h: 20.h),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "haveCompte".tr,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: grey8))),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                        text: "Connect2".tr,
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
