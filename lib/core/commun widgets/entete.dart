import 'package:flutter/material.dart';
import 'package:master_menu/core/commun%20widgets/custom_text.dart';
import 'package:master_menu/core/constants.dart';

class Entete extends StatelessWidget {
  const Entete({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all()),
              ),
              CustomText(
                  text: "Bonjour ,${user1.username}",
                  size: 18,
                  weight: FontWeight.w600,
                  coul: black),
              CustomText(
                  text: user1.role,
                  size: 14,
                  weight: FontWeight.w400,
                  coul: grey8),
            ],
          ),
          const Spacer(),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(
                    image: user1.role == "Serveur"
                        ? const AssetImage("assets/images/logo_serveur1.jpg")
                        : user1.role == "Caissier"
                            ? const AssetImage(
                                "assets/images/logo_caissier.png")
                            : const AssetImage(
                                "assets/images/logo_serveur1.jpg"),
                    fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
