import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:device_info/device_info.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/utilisateur.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CommFunc {
  //****************************************************** */
  static String DecodeTitre(String titre, String loca) {
    var son = json.decode(titre);
    String trans = "";
    if (loca == "ar")
      trans = son["ar"];
    else if (loca == "fr")
      trans = son["fr"] ?? "vide";
    else if (loca == "en") trans = son["en"] ?? "vide";

    return trans;
  }

//************************************************************************ */
  static Color ColorStatus(String stat) {
    Color coul = Colors.amber;
    if (stat == "0") {
      coul = Colors.orange;
    } else if (stat == "1") {
      coul = Colors.black;
    } else if (stat == "2") {
      coul = Colors.orange;
    } else {
      coul = Colors.green;
    }

    return coul;
  }

  //************************************************************************ */
  static String LabelStatus(String stat) {
    String label = "";

    if (stat == "0") {
      label = "programme".tr;
    } else if (stat == "1")
      label = "Disponible".tr;
    else if (stat == "2")
      label = "en attente".tr;
    else
      label = "recouvre".tr;

    return label;
  }

  //************************************************************************ */
  static Color colorTrans(int stat) {
    Color coul = Colors.amber;
    if (stat == 0) coul = Colors.red;
    if (stat == 1) coul = Colors.green;

    return coul;
  }

  //************************************************************************ */
  static String labelTrans(int stat) {
    String label = "";
    if (stat == 0) label = "nonPaye".tr;
    if (stat == 1) label = "paye".tr;

    return label;
  }

  //***************************************************** */
  static Future<String> getInitConfig() async {
    WebServices ws = WebServices();
    Reposit reposit = Reposit(ws);
    final box = GetStorage();
    reposit = Reposit(ws);
    dynamic decod;
    String resul = "";
    int currentVersion = 0;
    //int ExistUpdate = -1, requiredUpdate = -1;
    double lat = 0, lng = 0, zoom = 0;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = int.parse(packageInfo.buildNumber);

    deviceId = await box.read("deviceId") ?? "";

    if (deviceId == "") {
      var deviceInfo = DeviceInfoPlugin();
      if (deviceType == "android") {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
        box.write('DeviceId', deviceId);
      } else if (deviceType == "ios") {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
        box.write('DeviceId', deviceId);
      }
    }

    int lastVersion = -1, requiredVersion = -1, checkVersion = -1;

    await reposit.rep_getConfig().then((value) async => {
          print("***device type $value"),

          deviceType == "android"
              ? {
                  lastVersion = value["app_p_last_version"] ?? 0,
                  requiredVersion = value["app_p_required_version"] ?? 0,
                  checkVersion = value["app_p_check_version"] ?? 0,
                }
              : {
                  lastVersion = value["app_p_ios_last_version"] ?? 0,
                  requiredVersion = value["app_p_ios_required_version"] ?? 0,
                  checkVersion = value["app_p_ios_check_version"] ?? 0,
                },
          box.write("app_discount", value["app_discount"].toString()),
          box.write("client_discount", value["client_discount"].toString()),

          //token = await box.read("token") ?? "",
          if (checkVersion == 1)
            {
              if (lastVersion > currentVersion)
                {
                  if (requiredVersion > currentVersion)
                    {
                      resul = "required update",
                    }
                  else
                    resul = "can update",
                }
              else
                {
                  resul = "not update",
                }
            }
          else
            resul = "not update",
          decod = value["app_c_default_position"],
        });
    return resul;
  }

  //***************************************************************** */
  static showToast({required String content}) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //*************************************************************** */
  static ToMoney(int s) {
    String ss = s.toString();
    if (ss.length > 3)
      ss = ss.substring(0, ss.length - 3) +
          "," +
          ss.substring(ss.length - 3, ss.length);
    ss = ss + ".00 " + "da".tr;
    //  var f = NumberFormat("#,###.00");
    return ss;
    // f.format(s) + " DA";
  }

//**************************************************************** */
  static Future<void> openSession(Utilisateur uss) async {
    final box = GetStorage();
    box.write('logged', true);
    box.write('rest_id', uss.rest_id);
    box.write('rest_name', uss.rest_name);
    box.write('token', uss.token);
    box.write('role', uss.role);
  }

  //**************************************************************** */
  static Utilisateur ReadSession() {
    final box = GetStorage();

    return Utilisateur(
      rest_name: box.read('rest_name') ?? "",
      rest_id: box.read('rest_id') ?? -1,
      token: box.read('token') ?? "",
      role: box.read('role') ?? "",
      username: box.read('username') ?? "",
    );
  }

  //***************************************************************** */
  /* static DialogueLangue({required BuildContext cntx}) {
    var box = GetStorage();
    showDialog(
        context: cntx,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 250.h,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(15)),
              child: GetBuilder<Ctrl_settings>(
                  init: Ctrl_settings(),
                  builder: (val_ctrl) {
                    String ll = box.read("lng") ?? "";
                    if (ll == "ar") {
                      val_ctrl.selectedLangue = 3;
                    } else if (ll == "fr") {
                      val_ctrl.selectedLangue = 2;
                    } else if (ll == "en") {
                      val_ctrl.selectedLangue = 1;
                    }
                    val_ctrl.update();

                    return Column(
                      children: [
                        spaceV(30.h),
                        InkWell(
                          onTap: () {
                            Get.updateLocale(Locale("en"));
                            box.write("lng", "en");
                            val_ctrl.selectedLangue = 1;
                            val_ctrl.update();
                          },
                          child: ListTile(
                            title: const Text('English'),
                            leading: Container(
                              width: 20.w,
                              padding: EdgeInsets.only(left: 20.w),
                              child: Radio(
                                activeColor: PrimaryColor,
                                value: 1,
                                groupValue: val_ctrl.selectedLangue,
                                onChanged: (value) {
                                  Get.updateLocale(Locale("en"));
                                  box.write("lng", "en");
                                  val_ctrl.selectedLangue = value;
                                  val_ctrl.update();
                                },
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.updateLocale(Locale("fr"));
                            box.write("lng", "fr");
                            val_ctrl.selectedLangue = 2;
                            val_ctrl.update();
                          },
                          child: ListTile(
                            title: const Text('Français'),
                            leading: Container(
                              width: 20.w,
                              padding: EdgeInsets.only(left: 20.w),
                              child: Radio(
                                value: 2,
                                activeColor: PrimaryColor,
                                groupValue: val_ctrl.selectedLangue,
                                onChanged: (value) {
                                  Get.updateLocale(Locale("fr"));

                                  val_ctrl.selectedLangue = value;
                                  val_ctrl.update();
                                  box.write("lng", "fr");
                                },
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.updateLocale(Locale("ar"));
                            box.write("lng", "ar");
                            val_ctrl.selectedLangue = 3;
                            val_ctrl.update();
                          },
                          child: ListTile(
                            title: const Text('العربية'),
                            leading: Container(
                              width: 20.w,
                              padding: EdgeInsets.only(left: 20.w),
                              child: Radio(
                                value: 3,
                                activeColor: PrimaryColor,
                                groupValue: val_ctrl.selectedLangue,
                                onChanged: (value) {
                                  Get.updateLocale(Locale("ar"));
                                  box.write("lng", "ar");

                                  val_ctrl.selectedLangue = value;
                                  val_ctrl.update();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          );
        });
  }
*/
  //***************************************************************** */
  static void showDialogue({
    required BuildContext cntx,
    required String title,
    required String content,
    required String title_btn1,
    required VoidCallback btn1_Onclick,
    required String title_btn2,
    required VoidCallback btn2_Onclick,
  }) {
    showDialog(
        context: cntx,
        builder: (BuildContext context) {
          return Dialog(
            //this right here
            child: Container(
              height: 220,
              decoration: ShapeDecoration(
                color: white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpaceV(h: 20),
                    CustomText(
                        text: title,
                        size: 18,
                        weight: FontWeight.bold,
                        coul: black),
                    Expanded(
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        child: Image.asset("assets/images/logout_icone.png"),
                      ),
                    ),
                    CustomText(
                        text: content,
                        size: 16,
                        weight: FontWeight.w500,
                        coul: grey8),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: title_btn2.isNotEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 40.h,
                                  child: InkWell(
                                    onTap: btn2_Onclick,
                                    child: CustomText(
                                        text: title_btn2,
                                        size: 16,
                                        weight: FontWeight.w900,
                                        coul: Colors.grey),
                                  ),
                                ) /* ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: PrimaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  onPressed: btn2_Onclick,
                                  child: customText(
                                      title_btn2, 14, white, FontWeight.bold))
                             */
                              : Container(),
                        ),
                        Expanded(
                          child: title_btn1.isNotEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: btn1_Onclick,
                                    child: CustomText(
                                        text: title_btn1,
                                        size: 16,
                                        weight: FontWeight.w500,
                                        coul: PrimaryColor),
                                  ),
                                )

                              /* ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      maximumSize: Size(140, 40),
                                      backgroundColor: PrimaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  onPressed: btn1_Onclick,
                                  child: customText(
                                      title_btn1, 14, white, FontWeight.bold))
                            */
                              : Container(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  //**************************************************************** */
  static void closeSession() async {
    final box = GetStorage();
    print("zzzzzzzzzzzzzz 11 ${await box.read("logged")}");
    box.write('logged', false);

    box.write('username', "");
    box.write('qrcode', "");
    box.write('token', "");
    box.write('id', "");
    box.write('photo', "");
    print("zzzzzzzzzzzzzz 22 ${await box.read("logged")}");

    /* Ctrl_Home ctrl_home = Get.find();
    ctrl_home.islogin = false;
    ctrl_home.update();*/
  }

  //***************************************************************** */
  static Future<bool> checkInternet() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

//***************************************************** */
  ShowSnack(String titre, String content, IconData? iconee) {
    Color coul = Colors.orange;

    if (titre == "Confirmation") {
      coul = Color.fromARGB(255, 25, 177, 33);
    } else if (titre == "erreur") {
      coul = Color.fromARGB(255, 220, 55, 9);
    } else if (titre == "Avertissement") {
      coul = Color.fromARGB(255, 220, 130, 4);
    }

    Get.snackbar(
      titre,
      content,
      backgroundColor: coul,
      colorText: white,
      messageText: Text(
        content,
        style: GoogleFonts.urbanist(
            textStyle: TextStyle(color: white, fontSize: 16)),
      ),
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(10),
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        iconee,
        color: white,
        size: 25,
      ),
    );
  }
}
