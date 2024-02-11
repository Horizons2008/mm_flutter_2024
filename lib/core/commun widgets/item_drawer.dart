import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class ItemDrawer extends StatelessWidget {
  final String titre;
  final Icon? icon;
  final VoidCallback onclic;

  const ItemDrawer(
      {super.key, required this.titre, this.icon, required this.onclic});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(
          text: titre, size: 18, coul: black, weight: FontWeight.w400),
      leading: icon,
      onTap: onclic,
    );
  }
}
