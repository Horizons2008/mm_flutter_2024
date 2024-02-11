import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:master_menu/controller/controller_user.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Nouveau user",
            size: 16,
            weight: FontWeight.bold,
            coul: black),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
          child: GetBuilder<CtrlUser>(
              init: CtrlUser(),
              builder: (val1) {
                return Column(
                  children: [
                    CustomEdit(
                      onChange: (v) {
                        val1.textEditContusername.text = v;
                        val1.update();
                      },
                      teController: val1.textEditContusername,
                      hint: "Username",
                    ),
                    const SpaceV(h: 30),
                    CustomEdit(
                      onChange: (v) {
                        val1.textEditContPass.text;
                        val1.update();
                      },
                      teController: val1.textEditContPass,
                      hint: "Mot de passe",
                    ),
                    const SpaceV(h: 30),
                    DropdownButton(
                        value: val1.selectedRole,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text("Admin")),
                          DropdownMenuItem(value: 2, child: Text("Serveur")),
                          DropdownMenuItem(value: 3, child: Text("Caissier")),
                        ],
                        onChanged: (va) {
                          val1.selectedRole = va ?? 1;
                          val1.update();
                        }),
                    const SpaceV(h: 20),
                    CustomButton(
                        titre: "Ajouter User",
                        onclick: () {
                          val1.storeUser();
                        })
                  ],
                );
              }),
        ),
      ),
    );
  }
}
