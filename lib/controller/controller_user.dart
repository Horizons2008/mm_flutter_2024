import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/user.dart';

class CtrlUser extends GetxController {
  WebServices ws = WebServices();
  late Reposit reposit;
  List<String> Role = ["", "A", "S", "C"];
  int selectedRole = 1;
  int hintUsername = 0;
  int hintPassword = 0;

  List<MUser> listUsers = [];
  int last_record = 0;
  ScrollController scrollcontroller = ScrollController();
  int code = -1;
  String state = "";
  TextEditingController textEditContusername = TextEditingController();
  TextEditingController textEditContPass = TextEditingController();
  MUser selectedUser =
      MUser(id: -1, photos: "", role: "", status: "", username: "uui");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    reposit = Reposit(ws);
    scrollcontroller = ScrollController()..addListener(pagination);
    getlistUsers();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  //***************************************** */
  void pagination() async {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (state != "finished") &&
        (code == -1)) {
      code = 0;
      last_record = last_record + 10;
      state = "charging";
      update();
      getlistUsers();
    } else {}
  }

  //********************************************** */
  Future<void> getlistUsers() async {
    if (state == "") {
      state = "loading";
      update();
    }

    if (await CommFunc.checkInternet() == false) {
      state = "noInternet";
      update();
      CommFunc.showToast(content: "NoInternet".tr);
    } else {
      await reposit.rep_getUser(last_record, 10).then((value) => {
            print("get list users $value"),
            code = -1,
            if (value["status"] == 1)
              {
                listUsers = List.from(value["liste_users"])
                    .map((e) => MUser.fromJson(e))
                    .toList(),
                state = "loaded",
                update(),
              }
          });
    }
    update();
  }

  //*************************************** */
  Future deleteUser() async {
    if (selectedUser.id == -1) {
      CommFunc.showToast(content: "Vous devez selectiner un utilisateur");
    } else {
      reposit.repDestroyUser(selectedUser.id).then((value) => {
            print("zza $value"),
            if (value["status"] == 1)
              {
                CommFunc.showToast(
                    content: "Utilisateur supprimé avec succées"),
                getlistUsers(),
              }
          });
    }
  }

//************************************************** */
  Future<void> storeUser() async {
    if (textEditContusername.text.isEmpty) {
      hintUsername = 1;
      update();
    } else if (textEditContPass.text.isEmpty) {
      hintPassword = 1;
      update();
    } else {
      reposit
          .repStoreUser(selectedUser.id, textEditContusername.text,
              textEditContPass.text, Role[selectedRole])
          .then(
            (value) => {
              print("112 $value"),
              if (value["status"] == 2)
                {hintUsername = 3, update()}
              else if (value["status"] == 1)
                {
                  textEditContPass.text = "",
                  textEditContusername.text = "",
                  CommFunc.showToast(content: "Utilisateur inseré avec succés"),
                  Get.back(),
                  getlistUsers(),
                }
            },
          );
    }
  }
}
