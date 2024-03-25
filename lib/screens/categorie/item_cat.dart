import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:master_menu/controller/controller_cat.dart';

import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/space_hor.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/model/cat.dart';

class ItemCat extends StatelessWidget {
  const ItemCat({super.key, required this.item, required this.index});
  final MCat item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlCat>(builder: (val3) {
      print(baseUrl_photos + item.image);
      return InkWell(
        onTap: () {
          val3.selectedCat = item;
          val3.getlisteRepat();
          val3.update();
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.only(right: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: PrimaryColor, width: 1),
              color: val3.selectedCat == item
                  ? PrimaryColor
                  : PrimaryColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: /* Image.network(
                    baseUrl_photos + item.image, //url,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Text('N/A');
                    },
                  )*/

                    item.image.isNotEmpty
                        ? CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            imageUrl: baseUrl_photos + item.image,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : Image.asset("assets/images/logo.png"),
              ),
              const SpaceH(w: 5),
              CustomText(
                  text: item.title,
                  size: 14,
                  weight: FontWeight.w400,
                  coul: white),
            ],
          ),
        ),
      );
    });
  }
}
