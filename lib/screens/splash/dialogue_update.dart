import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/dashboard/screen_dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogueUpdate extends StatelessWidget {
  const DialogueUpdate({super.key, required this.conf});
  final String conf;

  @override
  Widget build(BuildContext context) {
    Future<void> launchURL() async {
      String url = "";

      deviceType == "android"
          ? url =
              "https://play.google.com/store/apps/details?id=com.dz.winsta_partner"
          : url = "https://apps.apple.com/app/winsta/id6474232485";

      url = Uri.encodeFull(url);
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          width: 350.w,
          height: 200.h,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Card(
              elevation: 12.sp,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    CustomText(
                      text: "Mise a jour disponible",
                      size: 21.sp,
                      weight: FontWeight.bold,
                      coul: black,
                    ),
                    SpaceV(h: 25),
                    CustomText(
                      text: "Veuillez installer la nouvelle version",
                      size: 14.sp,
                      weight: FontWeight.w300,
                      coul: black,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(145.sp, 40.sp),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {
                            launchURL();
                          },
                          child: const Text("Mettre a jour "),
                        ),
                        conf == "can update"
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    alignment: Alignment.center,
                                    fixedSize: Size(170.sp, 40.sp),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6))),
                                onPressed: () {
                                  Get.to(() => Dashboard());
                                },
                                child: const Text("Pas maintenant "))
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
