// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_commande.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/pleaseWait.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/server/commande/item_detail.dart';
import 'package:master_menu/screens/table/item_tables.dart';

class ListV_Detail extends StatelessWidget {
  const ListV_Detail({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> ref() async {
      /*    CtrlTable ctrl = Get.find();
      ctrl.last_record = 0;
      ctrl.state = "";
      ctrl.list_tables = [];
      ctrl.update();
      ctrl.getlistTable();*/
    }

    return GetBuilder<CtrlCommande>(
        init: CtrlCommande(),
        builder: (val1) {
          {
            return ListView.builder(
              itemCount: val1.commande1.detail.length,

              // controller: val.scrollcontroller,
              itemBuilder: (context, index) {
                return ItemDetail(
                  item: val1.commande1.detail[index],
                  index: index,
                );
              },
            );
          }
        });
  }
}
