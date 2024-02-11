import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/controller/controller_variant.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class ListV_Variant extends StatelessWidget {
  const ListV_Variant({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> ref() async {
      CtrlVariant ctrl = Get.find();
      ctrl.last_record = 0;
      ctrl.state = "";
      ctrl.listCat = [];
      ctrl.update();
      ctrl.getlistCat();
    }

    return GetBuilder<CtrlVariant>(
        init: CtrlVariant(),
        builder: (val) {
          {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    //width: double.infinity,

                    // margin: EdgeInsets.only(bottom: 10),
                    child: RefreshIndicator(
                      onRefresh: ref,
                      child: ListView.builder(
                        itemCount: val.listeVariant.length,

                        // controller: val.scrollcontroller,
                        itemBuilder: (context, index) {
                          return CustomText(
                              text: val.listeVariant[index].title,
                              size: 14,
                              weight: FontWeight.w500,
                              coul: black);
                        },
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
