import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_variant.dart';
import 'package:master_menu/core/commun%20widgets/btn_sm.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';

class ItemVariant1 extends StatelessWidget {
  const ItemVariant1({super.key, required this.item, required this.index});
  final item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 5, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                          text: item.title,
                          size: 16,
                          weight: FontWeight.w600,
                          coul: black),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  GetBuilder<CtrlVariant>(builder: (ctrl) {
                                    return Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 40),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: CustomText(
                                                  text: "Modifier Variant",
                                                  size: 18,
                                                  weight: FontWeight.w600,
                                                  coul: black),
                                            ),
                                            SpaceV(h: 35),
                                            CustomEdit(
                                              onChange: (val) {
                                                ctrl.tECTitleUpdateVariant
                                                    .text = val;
                                                ctrl.update();
                                              },
                                              teController:
                                                  ctrl.tECTitleUpdateVariant,
                                              hint: "Titre de variant",
                                            ),
                                            SpaceV(h: 15),
                                            BtnSm(
                                                titre: "Modifier",
                                                onclick: () {
                                                  ctrl.updateVariant(item.id);
                                                }),
                                          ]),
                                    );
                                  }));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          CtrlVariant ctrl = Get.find();
                          ctrl.destroyVariant(item.id);
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
