import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_variant.dart';
import 'package:master_menu/core/commun%20widgets/btn_sm.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_hor.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/variant/listv_variant.dart';

class ScreenVariant extends StatelessWidget {
  const ScreenVariant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Liste Variants",
            size: 18,
            weight: FontWeight.w500,
            coul: black),
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
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: val1.listCat.length,
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  val1.selectedCat = val1.listCat[index].id;
                                  val1.update();
                                  val1.getlistVariant();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: val1.selectedCat ==
                                              val1.listCat[index].id
                                          ? Colors.purple.shade100
                                          : white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.purple,
                                      )),
                                  child: CustomText(
                                      text: val1.listCat[index].title,
                                      size: 14,
                                      weight: FontWeight.w600,
                                      coul: black),
                                ))),
                      ),
                      const SpaceV(h: 20),
                      Row(
                        children: [
                          CustomEdit(
                            hint: "Nouveau Variant",
                            onChange: (v) {
                              val1.textEditContVariant.text = v;
                              val1.update();
                            },
                            teController: val1.textEditContVariant,
                          ),
                          const SpaceH(w: 5),
                          BtnSm(
                              titre: "Add ",
                              onclick: val1.textEditContVariant.text.isEmpty
                                  ? null
                                  : () {
                                      val1.storeVariant();
                                    }),
                        ],
                      ),
                      const SpaceV(h: 30),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(),
                            child: const ListV_Variant()),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
