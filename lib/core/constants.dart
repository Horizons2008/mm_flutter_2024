import 'package:flutter/material.dart';
import 'package:master_menu/model/utilisateur.dart';

//String baseUrl = "http://192.168.43.213/mm2023/public/api/";
String baseUrl = "http://192.168.43.213/mm2023/public/api/";
String baseUrl_photos = "https://dev.w-insta.com/storage/";

String deviceId = "";
String deviceType = "";
Color white = Colors.white;
Color black = Colors.black;
late Utilisateur user1;
const grey8 = Color(0xFF888888);
const grey6 = Color.fromARGB(255, 102, 102, 102);
const grey3 = Color(0xFF333333);
const PrimaryColor = Color(0xFFb7175f);

bool logged = false;
