import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/pleaseWait.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/table/add_table.dart';
import 'package:master_menu/screens/table/listv_tables.dart';

class ScreenTable extends StatelessWidget {
  const ScreenTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Liste tables",
            size: 18,
            weight: FontWeight.w500,
            coul: black),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          //   height: double.infinity,
          // color: Colors.grey.shade100,
          child: GetBuilder<CtrlTable>(
              init: CtrlTable(),
              builder: (val1) {
                if (val1.state == "loading") {
                  return Center(child: (PleaseWait(cont: context)));
                } else if (val1.state == "loaded") {
                  return const ListV_Tables();
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
