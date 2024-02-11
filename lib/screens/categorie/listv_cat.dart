import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
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
                      SpaceH(w: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                            onPressed: () {},
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
                              Get.to(() => const AddCat());
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
                    height: 100,
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
                          onPressed: () {
                            val.storeRepat();
                          },
                          child: const CustomText(
                              text: "Add Repat",
                              size: 16,
                              weight: FontWeight.w500,
                              coul: PrimaryColor))
                    ],
                  ),
                  CustomEdit(
                      hint: "Ajouter Repat ",
                      teController: val.textEditContNewReapt,
                      onChange: (text) {}),
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
