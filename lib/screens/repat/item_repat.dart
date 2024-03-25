import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';
import 'package:master_menu/controller/controller_detail.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_hor.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/repat.dart';
import 'package:master_menu/screens/details/screen_details.dart';

class ItemRepat extends StatelessWidget {
  const ItemRepat({super.key, required this.item, required this.index});
  final MRepat item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),

      // padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: PrimaryColor, width: 0.5),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50), topLeft: Radius.circular(50)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: item.image.isNotEmpty
                ? CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: baseUrl_photos + item.image,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Image.asset("assets/images/logo.png"),
          ),
          SpaceH(w: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                        text: item.title,
                        size: 16,
                        weight: FontWeight.w600,
                        coul: black),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          CtrlDetail ctrl = Get.put(CtrlDetail());
                          ctrl.getDetail(item.id);
                          ctrl.image = null;
                          ctrl.update();
                          showModalBottomSheet(
                              context: context,
                              scrollControlDisabledMaxHeightRatio: 0.8,
                              builder: (BuildContext context) {
                                return ScreenDetail(id: item.id);
                              });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        )),
                    IconButton(
                      onPressed: () {
                        CtrlCat ctrlCat = Get.put(CtrlCat());
                        ctrlCat.deleteRepat(item.id);
                      },
                      icon: const Icon(
                        Icons.close_sharp,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 23,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: item.variants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: CustomText(
                                text: item.variants[index].title,
                                size: 14,
                                weight: FontWeight.w500,
                                coul: grey8),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
