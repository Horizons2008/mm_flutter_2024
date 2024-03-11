// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/pleaseWait.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/server/home/item_tables.dart';
import 'package:master_menu/screens/table/item_tables.dart';

class ListV_TablesServeur extends StatelessWidget {
  const ListV_TablesServeur({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> ref() async {
      CtrlTable ctrl = Get.find();
      ctrl.last_record = 0;
      ctrl.state = "";
      ctrl.list_tables = [];
      ctrl.update();
      ctrl.getlistTable();
    }

    return GetBuilder<CtrlTable>(
        init: CtrlTable(),
        builder: (val) {
          if (val.state == "loading") {
            return Center(
              child: PleaseWait(cont: context),
            );
          } else if ((val.state == "finished") && (val.list_tables.isEmpty)) {
            return RefreshIndicator(
              onRefresh: ref,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                      child: CustomText(
                          text: "listeVide".tr,
                          size: 20.sp,
                          weight: FontWeight.w500,
                          coul: grey8)),
                ),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    //width: double.infinity,

                    // margin: EdgeInsets.only(bottom: 10),
                    child: RefreshIndicator(
                      onRefresh: ref,
                      child: GridView.builder(
                        itemCount: val.list_tables.length,

                        // controller: val.scrollcontroller,
                        itemBuilder: (context, index) {
                          return ItemTableServeur(
                            item: val.list_tables[index],
                            index: index,
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.5, crossAxisCount: 2),
                      ),
                    ),
                  ),
                ),
                val.state == "charging"
                    ? Container(
                        height: 30.h,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                    : Container()
              ],
            );
          }
        });
  }
}
