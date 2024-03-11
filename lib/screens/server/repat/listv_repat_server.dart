import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/screens/repat/item_repat.dart';
import 'package:master_menu/screens/server/repat/item_repat_server.dart';

class ListVRepatServer extends StatelessWidget {
  const ListVRepatServer({super.key});

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
                return ItemRepatServer(
                    item: val.listeRepat[index], index: index);
              },
            );
          }
        });
  }
}
