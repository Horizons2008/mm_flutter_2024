import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/controller/controller_user.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';

class AddCat extends StatelessWidget {
  const AddCat({super.key});

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
          child: GetBuilder<CtrlCat>(
              init: CtrlCat(),
              builder: (val1) {
                return Column(
                  children: [
                    CustomEdit(
                      onChange: (v) {
                        val1.textEditContTitle.text = v;
                        val1.update();
                      },
                      hint: "Nom Categorie",
                    ),
                    const SpaceV(h: 30),
                    const SpaceV(h: 20),
                    CustomButton(
                        titre: "Ajouter User",
                        onclick: () {
                          val1.storeCat();
                        })
                  ],
                );
              }),
        ),
      ),
    );
  }
}
