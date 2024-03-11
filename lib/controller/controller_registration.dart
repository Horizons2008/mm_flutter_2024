import 'package:get/get.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/utilisateur.dart';
import 'package:master_menu/screens/login/screenLogin.dart';

class Ctrl_Regis extends GetxController {
  String rest_name = "";

  String username = "";
  String pass = "";

  String deviceId = "";
  int hintUser = 0, hintRest = 0, hintPass = 0;

  String state = "";
  WebServices ws = WebServices();
  late Reposit reposit;
  late Utilisateur user;
  //********************************* */
  setRestName(String ss) {
    rest_name = ss;
    state = "";
    hintRest = 0;
    hintUser = 0;
    hintPass = 0;

    update();
  }

  //********************************* */
  setUsername(String ss) {
    username = ss;
    state = "";
    hintRest = 0;
    hintUser = 0;
    hintPass = 0;

    update();
  }

  //********************************** */
  setPass(String ss) {
    pass = ss;
    state = "";
    hintRest = 0;
    hintUser = 0;
    hintPass = 0;

    update();
  }

  //********************************** */
  saveRegis() async {
    //Ctrl_dashboard ctrl = Get.find();
    if (await CommFunc.checkInternet() == false) {}
    /*    ShowSnack(
          0,
          "Erreur".tr,
          "vous etes hors connexion",
          Icon(
            Icons.wifi_off,
            size: 30,
            color: white,
          ));
    else*/
    if (rest_name == "") {
      state = "userEmpty";
      hintRest = 1;
      update();
    } else if (username == "") {
      state = "userEmpty";
      hintUser = 1;
      update();
    } else if (pass == "") {
      state = "passEmpty";
      hintPass = 1;
      update();
    } else if (pass.length < 6) {
      hintPass = 2;
      state = "passCour";
      update();
    } else {
      reposit = Reposit(ws);
      state = "loading";
      update();
      /* await reposit.rep_checkUser(username).then((value) async => {
           
            if (value["status"] == 0)
              {
                state_reg = "UserExist",
                update(),
              }
            else*/
      {
        state = "loading";
        update();
        reposit = Reposit(ws);
        await reposit
            .rep_registration(rest_name, username, pass)
            .then((value) => {
                  print("value $value"),
                  state = "loaded",
                  update(),
                  if (value["status"] == 1)
                    {
                      //      user = Utilisateur.fromJson(value["client"]),
                      //    CommFunc.openSession(true, user),
                      //  ctrl.currentIndex = 0,
                      //ctrl.update(),
                      state = "logged",
                      update(),
                      Future.delayed(Duration(seconds: 2)),
                      Get.off(() => ScreenLogin()),

                      CommFunc.showToast(content: "compte_create_succes".tr)
                    }
                  else if (value["status"] == 2)
                    {
                      hintRest = 3,
                     
                    }
                  else if (value["status"] == 3)
                    {
                      hintUser = 3,
                      //      user = Utilisateur.fromJson(value["client"]),
                      //    CommFunc.openSession(true, user),
                      //  ctrl.currentIndex = 0,
                      //ctrl.update(),
                    },

                  /*  else if (value["error"] != null)
                            {
                                  ShowSnack(
                                  0,
                                  "Erreur".tr,
                                  value["error"],
                                  Icon(
                                    Icons.error,
                                    size: 30,
                                    color: white,
                                  ))
                            },*/
                  update(),
                });
      }
    }
  }
}
