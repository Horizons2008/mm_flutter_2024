import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_detail.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/variant.dart';
import 'package:master_menu/screens/details/item_repat_variant.dart';

class ScreenDetail extends StatelessWidget {
  const ScreenDetail({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    CtrlDetail ctrl = Get.put(CtrlDetail());
    ctrl.getDetail(id);

    return Scaffold(body: SafeArea(
      child: GetBuilder<CtrlDetail>(builder: (val) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomEdit(
                  teController: val.tECTitleDetail,
                  onChange: (va) {
                    val.repat.title = va;
                    val.update();
                  }),
              const SpaceV(h: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Variants",
                      size: 16,
                      weight: FontWeight.bold,
                      coul: black),
                  ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: white,
                            context: context,
                            builder: (BuildContext context) {
                              return GetBuilder<CtrlDetail>(builder: (vel) {
                                return SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Container(
                                    width: double.infinity,
                                    height: 500,
                                    color: white,
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: CustomText(
                                              text: "Ajouter Variant",
                                              size: 18,
                                              weight: FontWeight.w400,
                                              coul: black),
                                        ),
                                        DropdownButton(
                                            value: vel.selectedVariant,
                                            isExpanded: true,
                                            items: vel.itemsVariant,
                                            onChanged: (va) {
                                              vel.selectedVariant = va;

                                              vel.update();
                                              print(
                                                  "vava selected ${va!.title}");
                                              print("vava selected ${va!.id}");

                                              // val.getlistVariant();
                                            }),
                                        CustomEdit(
                                          onChange: (cc) {},
                                          hint: "Prix",
                                          teController: vel.tECPrix,
                                        ),
                                        CustomButton(
                                            titre: "valider",
                                            onclick: () {
                                              /// vel.updateVariant();
                                              vel.storeRepatVariant(
                                                  vel.selectedVariant!.id,
                                                  vel.repat.id);
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              });
                            });
                      },
                      child: CustomText(
                          text: "Add variant",
                          size: 16,
                          weight: FontWeight.bold,
                          coul: black))
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: val.repat.variants.length,
                    itemBuilder: (context, index) {
                      return ItemRepatVariant(item: val.repat.variants[index]);
                    }),
              ),
              CustomButton(
                  titre: "Enregistrer",
                  onclick: () {
                    val.updateRepat();
                  }),
              const SpaceV(h: 20)
            ],
          ),
        );
      }),
    ));
  }
}
