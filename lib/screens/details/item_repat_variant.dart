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

class ItemRepatVariant extends StatelessWidget {
  const ItemRepatVariant({super.key, required this.item});
  final MVariant item;

  @override
  Widget build(BuildContext context) {
    CtrlDetail ctrlDetail = Get.put(CtrlDetail());
    return Container(
      height: 70,
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Card(
          color: Colors.grey[100],
          surfaceTintColor: white,
          child: Container(
              //  padding: const EdgeInsets.all(5),
              child: ListTile(
            title: CustomText(
                text: " ${item.title} ",
                size: 16,
                weight: FontWeight.w600,
                coul: black),
            subtitle: CustomText(
                text: CommFunc.ToMoney(item.prix),
                size: 15,
                weight: FontWeight.w600,
                coul: grey8),
            trailing: Wrap(
              spacing: 0, // space between two icons
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return GetBuilder<CtrlDetail>(builder: (va3) {
                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    top: 15, right: 10, left: 10),
                                child: Column(
                                  children: [
                                    CustomText(
                                        text: "Modifier variant",
                                        size: 18,
                                        weight: FontWeight.w600,
                                        coul: black),
                                    const SpaceV(h: 20),
                                    CustomEdit(
                                      onChange: (val) {},
                                      teController: va3.tECPrix,
                                      hint: "Nouveau prix",
                                    ),
                                    SpaceV(h: 30),
                                    CustomButton(
                                        titre: "Modifier",
                                        onclick: () {
                                          va3.updateRepatVariant("1", item.id);
                                        })
                                  ],
                                ),
                              );
                            });
                          });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    )),
                IconButton(
                    onPressed: () {
                      ctrlDetail.deleteRepatVariant(item.id);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    )) // icon-1
                // icon-2
              ],
            ),
          ))),
    );
  }
}
