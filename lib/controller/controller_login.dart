import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/utilisateur.dart';
import 'package:master_menu/screens/dashboard/screen_dashboard.dart';
import 'package:master_menu/screens/server/home/screen_table.dart';

class Ctrl_login extends GetxController {
  String username = "";
  String password = "";
  String gmail = "";
  int hint_user = 0;
  int hint_pass = 0;
  bool showPassword = false;

  String state_login = "";
  WebServices ws = WebServices();
  late Reposit reposit;
  bool savePassword = false;

  changeSavePassword() {
    savePassword = !savePassword;
    update();
  }

  //***************************************** */
  setUsername(String ch) {
    username = ch;
    state_login = "";
    hint_user = 0;
    hint_pass = 0;
    update();
  }

  //***************************************** */
  setPassword(String ch) {
    password = ch;
    state_login = "";
    hint_user = 0;
    hint_pass = 0;
    update();
  }

  //************************************************ */
  Future<void> checkLogin(String type, String name, String deviceId,
      String mail, String fb_token) async {
    if (await CommFunc.checkInternet() == false)
      CommFunc.showToast(content: "NoInternet".tr);
    else if ((username == "") && (type == "user")) {
      hint_user = 1;
      update();
    } else if ((password == "") && (type == "user")) {
      hint_pass = 1;
      update();
    } else {
      state_login = "loading";
      update();

      reposit = Reposit(ws);

      await reposit
          .rep_checkLogin(username, password, name, gmail, fb_token)
          .then((value) async => {
                if (value["status"] == 1)
                  {
                    debugPrint("$value"),
                    state_login = "logged",
                    update(),
                    user1 = Utilisateur.fromJson(value),
                    print("xxw ${user1}  ${user1.role}"),
                    //  user1 = user,
                    await CommFunc.openSession(user1),

                    //  checkUpdate = await CommFunc.getInitConfig(),

                    //   if (checkUpdate == "not update")

                    Future.delayed(Duration(seconds: 1)),
                    if (value["role"] == "A")
                      {Get.off(() => Dashboard())}
                    else if (value["role"] == "S")
                      Get.off(() => DashboardServer()),

                    /*    else
                      {
                        //Get.off(() => DialogueUpdate(conf: checkUpdate))
                      }*/

                    //   ctrl.currentIndex = 0,
                    //   ctrl.update(),
                  }
                else if (value["status"] == 0)
                  {
                    gmail = "",
                    GoogleSignIn().signOut(),
                    state_login = "NotExiste",
                    hint_user = 4,
                    update(),
                  }
                else if (value["status"] == 3)
                  {
                    gmail = "",
                    GoogleSignIn().signOut(),
                    state_login = "NotExiste",
                    hint_user = 4,
                    update(),
                  }
                else if (value["status"] == 2)
                  {
                    gmail = "",
                    GoogleSignIn().signOut(),
                    state_login = "Blocked",
                    update(),
                  }
                else if (value["error"] != null)
                  {
                    CommFunc.showToast(
                      content: "Erreur : ".tr + value["error"],
                    ),
                    state_login = "",
                    update(),
                  }
              });
    }
  }
}
