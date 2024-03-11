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
import 'package:master_menu/screens/server/categorie/item_cat_server.dart';
import 'package:master_menu/screens/server/repat/listv_repat_server.dart';
import 'package:master_menu/screens/variant/listv_variant.dart';

class ListVCatServer extends StatelessWidget {
  const ListVCatServer({super.key});

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
                  const SpaceV(h: 15),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: val.listCat.length,
                      scrollDirection: Axis.horizontal,

                      // controller: val.scrollcontroller,
                      itemBuilder: (context, index) {
                        return ItemCatServer(
                          item: val.listCat[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                  CustomText(
                      text: "Repats",
                      size: 14,
                      weight: FontWeight.bold,
                      coul: black),
                  val.listeRepat.isNotEmpty
                      ? const Expanded(child: ListVRepatServer())
                      : const SizedBox()
                ],
              ),
            );
          }
        });
  }
}
