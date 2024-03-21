import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:master_menu/core/constants.dart';

class CustomEdit extends StatelessWidget {
  CustomEdit({
    super.key,
    this.hint,
    required this.onChange,
    this.teController,
    this.iconDroite,
    this.showPass,
    this.dataType,
  });
  final String? hint;
  final ValueChanged<String> onChange;
  final TextEditingController? teController;
  final TextInputType? dataType;

  final Widget? iconDroite;
  final bool? showPass;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 50,
      width: 250,
      alignment: Alignment.centerLeft,

      child: CupertinoTextField(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        controller: teController,
        placeholder: hint,
        onChanged: onChange,
        keyboardType: dataType ?? TextInputType.name,
        obscureText: showPass ?? false,
        suffix: iconDroite,
        decoration: BoxDecoration(
            border: Border.all(color: PrimaryColor, width: 0.7),
            borderRadius: BorderRadius.circular(7)),
      ),
    );
  }
}
