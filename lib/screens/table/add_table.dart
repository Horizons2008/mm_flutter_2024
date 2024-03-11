import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:master_menu/controller/controller_table.dart';
import 'package:master_menu/core/commun%20widgets/custom_button.dart';
import 'package:master_menu/core/commun%20widgets/custom_edit.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/hint_edit.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';

class AddTable extends StatelessWidget {
  const AddTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: GetBuilder<CtrlTable>(
                init: CtrlTable(),
                builder: (val1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Nom table",
                          size: 14,
                          weight: FontWeight.w500,
                          coul: black),
                      SpaceV(h: 5),
                      CustomEdit(
                        onChange: (v) {
                          val1.textEditContNomTable.text = v;
                          val1.hint = 0;
                          val1.hint_chaise = 0;
                          val1.update();
                        },
                        teController: val1.textEditContNomTable,
                        hint: "Nom table",
                      ),
                      HintError(ind: val1.hint),
                      SpaceV(h: 20),
                      CustomText(
                          text: "Nombre de chaises",
                          size: 14,
                          weight: FontWeight.w500,
                          coul: black),
                      SpaceV(h: 5),
                      CustomEdit(
                        onChange: (v) {
                          val1.textEditContNbrChaise.text;
                          val1.hint = 0;
                          val1.hint_chaise = 0;
                          val1.update();
                        },
                        teController: val1.textEditContNbrChaise,
                        hint: "Nombre chaise",
                      ),
                      HintError(ind: val1.hint_chaise),
                      SpaceV(h: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: "Etat",
                              size: 14,
                              weight: FontWeight.w500,
                              coul: black),
                          Container(
                            width: 120,
                            height: 40,
                            child: LiteRollingSwitch(
                                colorOff: Colors.grey,
                                colorOn: PrimaryColor,
                                textOnColor: white,
                                textOn: "Activé",
                                textOff: "Bloqué",
                                iconOff: Icons.close,
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                                onChanged: (v) {
                                  val1.status_table = v;
                                  val1.update();
                                }),
                          )
                        ],
                      ),
                      SpaceV(h: 15),
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
      ),
    );
  }
}
