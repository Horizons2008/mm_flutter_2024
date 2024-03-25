import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/core/commun%20widgets/btn_sm.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/pleaseWait.dart';
import 'package:master_menu/core/commun%20widgets/space_hor.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/categorie/add_cat.dart';
import 'package:master_menu/screens/categorie/item_cat.dart';
import 'package:master_menu/screens/repat/listv_repat.dart';
import 'package:master_menu/screens/variant/listv_variant.dart';

class ListV_Cat extends StatelessWidget {
  const ListV_Cat({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> ref() async {
      CtrlCat ctrl = Get.find();
      ctrl.last_record = 0;
      ctrl.state = "";
      ctrl.listCat = [];
      ctrl.update();
      ctrl.getlistCat();
    }

    return GetBuilder<CtrlCat>(
        init: CtrlCat(),
        builder: (val) {
          {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                          text: "Categorie",
                          size: 18,
                          weight: FontWeight.bold,
                          coul: black),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                            onPressed: () {
                              val.deleteCat();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                      const SpaceH(w: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                            onPressed: () {
                              //val.selectedUser.username = "";
                              val.textEditContTitle.text =
                                  val.selectedCat.title;
                              val.image = null;

                              /*  val.selectedCat.image != ""
                                  ? val.image = File.fromUri(Uri.file(
                                      "http://192.168.1.213/mm2023/public/photos/1711290660.png"))
                                  : val.image = null;*/

                              val.update();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddCat(
                                      image_url: val.selectedCat.image,
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                      ),
                      SpaceH(w: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                            onPressed: () {
                              val.selectedCat.id = -1;
                              //val.selectedUser.username = "";
                              val.textEditContTitle.text = "";

                              val.update();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AddCat(
                                      image_url: "",
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.green,
                            )),
                      ),
                    ],
                  ),
                  const SpaceV(h: 15),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemCount: val.listCat.length,
                      scrollDirection: Axis.horizontal,

                      // controller: val.scrollcontroller,
                      itemBuilder: (context, index) {
                        return ItemCat(
                          item: val.listCat[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Repats",
                          size: 14,
                          weight: FontWeight.bold,
                          coul: black),
                      TextButton(
                          onPressed: () {},
                          child: const CustomText(
                              text: "Add Repat",
                              size: 16,
                              weight: FontWeight.w500,
                              coul: PrimaryColor))
                    ],
                  ),
                  Row(
                    children: [
                      CustomEdit(
                          hint: "Ajouter Repat ",
                          teController: val.textEditContNewReapt,
                          onChange: (text) {
                            val.textEditContNewReapt.text = text;
                            val.update();
                          }),
                      SpaceH(w: 5),
                      val.textEditContNewReapt.text.isNotEmpty
                          ? BtnSm(
                              titre: "Ajouter +",
                              onclick: () {
                                val.storeRepat();
                              })
                          : const SizedBox() //Upa457663    45757663
                    ],
                  ),
                  val.listeRepat.isNotEmpty
                      ? const Expanded(child: ListVRepat())
                      : const SizedBox()
                ],
              ),
            );
          }
        });
  }
}
