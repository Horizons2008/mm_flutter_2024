import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:master_menu/core/constants.dart';

class CustomEdit extends StatelessWidget {
  const CustomEdit({
    super.key,
    this.hint,
    required this.onChange,
    this.teController,
    this.iconDroite,
    this.showPass,
  });
  final String? hint;
  final ValueChanged<String> onChange;
  final TextEditingController? teController;
  final Widget? iconDroite;
  final bool? showPass;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      //padding: EdgeInsets.only(right: 10, left: 10),
      child: CupertinoTextField(
        padding: EdgeInsets.only(right: 10, left: 10),
        controller: teController,
        placeholder: hint,
        onChanged: onChange,
        obscureText: showPass ?? false,
        suffix: iconDroite,
        decoration: BoxDecoration(
            border: Border.all(color: PrimaryColor, width: 0.7),
            borderRadius: BorderRadius.circular(7)),
      ),
    );
  }
}
