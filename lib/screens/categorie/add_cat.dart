import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/hint_edit.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';

class AddCat extends StatelessWidget {
  const AddCat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Nouveau Categorie",
            size: 16,
            weight: FontWeight.bold,
            coul: black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: GetBuilder<CtrlCat>(
                init: CtrlCat(),
                builder: (val1) {
                  return Column(
                    children: [
                      CustomEdit(
                        teController: val1.textEditContTitle,
                        onChange: (v) {
                          val1.textEditContTitle.text = v;
                          val1.hintCat = 0;
                          val1.update();
                        },
                        hint: "Nom Categorie",
                      ),
                      HintError(ind: val1.hintCat),
                      InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          padding: EdgeInsets.all(50),
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: PrimaryColor, width: 0.7)),
                          child: Image.asset("assets/images/pic.png"),
                        ),
                      ),
                      const SpaceV(h: 20),
                      val1.state == "loading"
                          ? CustomButton(titre: "Traitement", onclick: () {})
                          : CustomButton(
                              titre: "Ajouter Categorie",
                              onclick: () {
                                val1.storeCat();
                              })
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
