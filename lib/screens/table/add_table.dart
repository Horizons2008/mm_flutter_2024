import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';

class AddTable extends StatelessWidget {
  const AddTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(left: 10, right: 10, top: 15),
          child: GetBuilder<CtrlTable>(
              init: CtrlTable(),
              builder: (val1) {
                return Column(
                  children: [
                    CustomEdit(
                      onChange: (v) {
                        val1.textEditContNomTable.text = v;
                        val1.update();
                      },
                      teController: val1.textEditContNomTable,
                      hint: "Nom table",
                    ),
                    SpaceV(h: 30),
                    CustomEdit(
                      onChange: (v) {
                        val1.textEditContNbrChaise.text;
                        val1.update();
                      },
                      teController: val1.textEditContNbrChaise,
                      hint: "Nombre chaise",
                    ),
                    CustomButton(
                        titre: "Ajouter Table",
                        onclick: () {
                          val1.storeTable();
                        })
                  ],
                );
              }),
        ),
      ),
    );
  }
}
