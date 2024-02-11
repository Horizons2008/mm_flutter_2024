import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/controller/controller_variant.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/pleaseWait.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/categorie/add_cat.dart';
import 'package:master_menu/screens/categorie/listv_cat.dart';
import 'package:master_menu/screens/variant/listv_variant.dart';

class ScreenVariant extends StatelessWidget {
  const ScreenVariant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Liste Categorie",
            size: 18,
            weight: FontWeight.w500,
            coul: black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddCat());
        },
        child: CustomText(
            text: " + ", size: 22, weight: FontWeight.w500, coul: black),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          //   height: double.infinity,
          // color: Colors.grey.shade100,
          child: GetBuilder<CtrlVariant>(
              init: CtrlVariant(),
              builder: (val1) {
                return Container(
                  width: 320,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                  child: Column(
                    children: [
                      const CustomText(
                          text: "Categorie",
                          size: 14,
                          weight: FontWeight.w400,
                          coul: Colors.red),
                      DropdownButton(
                          value: val1.selectedCat,
                          isExpanded: true,
                          items: val1.items,
                          onChanged: (va) {
                            val1.selectedCat = va ?? -1;

                            val1.update();
                            val1.getlistVariant();
                          }),
                      const SpaceV(h: 15),
                      CustomEdit(
                        hint: "Nouveau Variant",
                        onChange: (v) {},
                        teController: val1.textEditContVariant,
                      ),
                      CustomButton(
                          titre: "Add variant",
                          onclick: () {
                            val1.storeVariant();
                          }),
                      const SpaceV(h: 30),
                      Container(
                          height: 300,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: PrimaryColor, width: 1)),
                          child: const ListV_Variant())
                    ],
                  ),
                );
                if (val1.state == "loading") {
                  return Center(child: (PleaseWait(cont: context)));
                } else if (val1.state == "loaded") {
                  return const ListV_Cat();
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
