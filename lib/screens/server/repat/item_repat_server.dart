import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_commande.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/repat.dart';
import 'package:master_menu/screens/server/detail/screen_detail_server.dart';

class ItemRepatServer extends StatelessWidget {
  const ItemRepatServer({super.key, required this.item, required this.index});
  final MRepat item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CtrlCommande ctrlCommande = Get.put(CtrlCommande());
        ctrlCommande.getDetail(item.id);
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            scrollControlDisabledMaxHeightRatio: 0.25,
            shape: const RoundedRectangleBorder(
              // <-- SEE HERE
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            context: context,
            builder: (BuildContext context) {
              return DetailRepatServer();
            });
        // Get.to(() => const DetailRepatServer());
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceV(h: 50),
              Card(
                surfaceTintColor: white,
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(7),
                  child: Column(
                    children: [
                      SpaceV(h: 80),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: item.title,
                                    size: 18,
                                    weight: FontWeight.w500,
                                    coul: black),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: CustomText(
                                      text: item.inOrder,
                                      size: 10,
                                      weight: FontWeight.w400,
                                      coul: black),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: PrimaryColor.withOpacity(0.1),
                            child: Icon(Icons.add_shopping_cart_sharp,
                                color: PrimaryColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            //  width: 100,
            height: 100,
            color: Colors.transparent,
            alignment: Alignment.center,

            child: Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: item.image.isNotEmpty
                  ? CircleAvatar(
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        fit: BoxFit.fill,
                        imageUrl: baseUrl_photos + item.image,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
