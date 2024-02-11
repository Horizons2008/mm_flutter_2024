import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/commun%20widgets/item_drawer.dart';
import 'package:master_menu/core/commun%20widgets/space_ver.dart';
import 'package:master_menu/screens/categorie/screen_categorie.dart';
import 'package:master_menu/screens/table/screen_table.dart';
import 'package:master_menu/screens/user/screen_user.dart';
import 'package:master_menu/screens/variant/screen_vaiant.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SpaceV(h: 150),
          ItemDrawer(
            titre: "Home",
            onclic: () {},
            icon: const Icon(Icons.home),
          ),
          ItemDrawer(
            titre: "Liste Table",
            onclic: () {
              Get.to(() => const ScreenTable());
            },
            icon: const Icon(Icons.home),
          ),
          ItemDrawer(
            titre: "Liste Utilisateur",
            onclic: () {
              Get.to(() => const ScreenUser());
            },
            icon: const Icon(Icons.person),
          ),
          ItemDrawer(
            titre: "Categories & Plats",
            onclic: () {
              Get.to(() => const ScreenCat());
            },
            icon: const Icon(Icons.category_sharp),
          ),
          ItemDrawer(
            titre: "Variant",
            onclic: () {
              Get.to(() => const ScreenVariant());
            },
            icon: const Icon(Icons.category_sharp),
          )
        ],
      ),
    );
  }
}
