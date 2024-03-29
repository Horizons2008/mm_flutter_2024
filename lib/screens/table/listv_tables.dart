// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/pleaseWait.dart';
import 'package:master_menu/core/commun%20widgets/space_hor.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/table/add_table.dart';
import 'package:master_menu/screens/table/item_tables.dart';

class ListV_Tables extends StatelessWidget {
  const ListV_Tables({super.key});

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
                            val.DestroyTable();
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
                          onPressed: () {
                            val.textEditContNomTable.text =
                                val.SelectedTableId.name;
                            val.textEditContNbrChaise.text =
                                val.SelectedTableId.nbr_chaise;

                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AddTable();
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                    ),
                    const SpaceH(w: 10),
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AddTable();
                                });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                          )),
                    ),
                  ],
                ),
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
                          return ItemTable(
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
