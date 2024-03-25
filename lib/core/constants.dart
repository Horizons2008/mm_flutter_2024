import 'package:flutter/material.dart';
import 'package:master_menu/core/divers/repositorie.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/utilisateur.dart';

String baseUrl = "http://192.168.1.213/mm2023/public/api/";
//String baseUrl = "http://192.168.43.213/mm2023/public/api/";
String baseUrl_photos = "http://192.168.1.213/mm2023/public/";

String deviceId = "";
String deviceType = "";
Color white = Colors.white;
Color black = Colors.black;
int typeRequest = 0;
late Utilisateur user1;
const grey8 = Color(0xFF888888);
const grey6 = Color.fromARGB(255, 102, 102, 102);
const grey3 = Color(0xFF333333);
const PrimaryColor = Color(0xFFF37B2D);
WebServices ws1 = WebServices();
Reposit reposit1 = Reposit(ws1);

bool logged = false;
