import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:master_menu/core/constants.dart';

class CustomEdit extends StatelessWidget {
  const CustomEdit({
    super.key,
    this.hint,
    required this.onChange,
    this.teController,
  });
  final String? hint;
  final ValueChanged<String> onChange;
  final TextEditingController? teController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: CupertinoTextField(
        controller: teController,
        placeholder: hint,
        onChanged: onChange,
        decoration: BoxDecoration(
            border: Border.all(color: PrimaryColor, width: 0.7),
            borderRadius: BorderRadius.circular(7)),
      ),
    );
  }
}
