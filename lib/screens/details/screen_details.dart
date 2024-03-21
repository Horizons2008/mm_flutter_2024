import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_detail.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/details/item_repat_variant.dart';

class ScreenDetail extends StatelessWidget {
  const ScreenDetail({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: GetBuilder<CtrlDetail>(builder: (val) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 450,
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
                          val.tECPrix.text = "";
                          val.update();
                          showModalBottomSheet(
                              backgroundColor: white,
                              context: context,
                              builder: (BuildContext context) {
                                return GetBuilder<CtrlDetail>(builder: (vel) {
                                  return SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Container(
                                      width: double.infinity,
                                      height: 500,
                                      color: white,
                                      margin: const EdgeInsets.all(10),
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
                                          SpaceV(h: 40),
                                          SizedBox(
                                            height: 30,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    vel.listeVariant.length,
                                                itemBuilder: (context, index) =>
                                                    InkWell(
                                                        onTap: () {
                                                          vel.selectedVariant =
                                                              vel.listeVariant[
                                                                  index];
                                                          vel.update();
                                                          //val1.getlistVariant();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: vel.selectedVariant ==
                                                                          vel.listeVariant[
                                                                              index]
                                                                      ? Colors
                                                                          .purple
                                                                          .shade100
                                                                      : white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .purple,
                                                                  )),
                                                          child: CustomText(
                                                              text: vel
                                                                  .listeVariant[
                                                                      index]
                                                                  .title,
                                                              size: 14,
                                                              weight: FontWeight
                                                                  .w600,
                                                              coul: black),
                                                        ))),
                                          ),
                                          const SpaceV(h: 15),
                                          CustomText(
                                              text: "Prix",
                                              size: 15,
                                              weight: FontWeight.w600,
                                              coul: black),
                                          const SpaceV(h: 5),
                                          CustomEdit(
                                            onChange: (cc) {},
                                            hint: "Prix",
                                            dataType: TextInputType.number,
                                            teController: vel.tECPrix,
                                          ),
                                          SpaceV(h: 25),
                                          CustomButton(
                                              titre: "valider",
                                              onclick: val.tECPrix.text.isEmpty
                                                  ? null
                                                  : () {
                                                      /// vel.updateVariant();
                                                      vel.storeRepatVariant(
                                                          vel.selectedVariant!
                                                              .id,
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
                        return ItemRepatVariant(
                            item: val.repat.variants[index]);
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
          ),
        );
      }),
    ));
  }
}
