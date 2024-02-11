import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/screens/repat/item_repat.dart';

class ListVRepat extends StatelessWidget {
  const ListVRepat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlCat>(
        init: CtrlCat(),
        builder: (val) {
          {
            print("lllist repat ${val.listeRepat.length}");
            return ListView.builder(
              itemCount: val.listeRepat.length,

              // controller: val.scrollcontroller,
              itemBuilder: (context, index) {
                return ItemRepat(item: val.listeRepat[index], index: index);
              },
            );
          }
        });
  }
}
