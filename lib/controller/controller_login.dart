import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/utilisateur.dart';
import 'package:master_menu/screens/dashboard/screen_dashboard.dart';

class Ctrl_login extends GetxController {
  String username = "";
  String password = "";
  String gmail = "";
  int hint_user = 0;
  int hint_pass = 0;

  String state_login = "";
  WebServices ws = WebServices();
  late Reposit reposit;
  bool savePassword = false;

  Utilisateur user = Utilisateur(
    rest_id: -1,
    rest_name: "",
    token: "",
  );

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
    print("username $username  password $password");

    final box = GetStorage();
    if (await CommFunc.checkInternet() == false)
      /* ShowSnack(
          0,
          "Erreur".tr,
          "NoInternet".tr,
          Icon(
            Icons.wifi_off,
            size: 30,
            color: white,
          ));*/
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
      String checkUpdate = "";
      await reposit
          .rep_checkLogin(username, password, name, gmail, fb_token)
          .then((value) async => {
                print("valllue   $value"),
                if (value["status"] == 1)
                  {
                    state_login = "logged",
                    update(),
                    user = Utilisateur.fromJson(value),
                    await CommFunc.openSession(true, user),
                    print("loggged"),
                    //  checkUpdate = await CommFunc.getInitConfig(),

                    //   if (checkUpdate == "not update")
                   
                      Future.delayed(Duration(seconds: 2)),
                      Get.off(() => Dashboard()),
                    
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
