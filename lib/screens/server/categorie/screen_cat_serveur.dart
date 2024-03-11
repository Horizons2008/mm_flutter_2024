import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/pleaseWait.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/screens/categorie/add_cat.dart';
import 'package:master_menu/screens/categorie/listv_cat.dart';
import 'package:master_menu/screens/server/categorie/listv_cat_server.dart';

class ScreenCatServer extends StatelessWidget {
  const ScreenCatServer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Liste Categorie",
            size: 18,
            weight: FontWeight.w500,
            coul: black),
      ),
      
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          //   height: double.infinity,
          // color: Colors.grey.shade100,
          child: GetBuilder<CtrlCat>(
              init: CtrlCat(),
              builder: (val1) {
                if (val1.state == "loading") {
                  return Center(child: (PleaseWait(cont: context)));
                } else if (val1.state == "loaded") {
                  return const ListVCatServer();
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
