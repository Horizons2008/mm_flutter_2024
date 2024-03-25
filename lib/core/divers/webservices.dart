import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/core/constants.dart';
import 'package:master_menu/core/dio/dioException.dart';
import 'package:master_menu/core/dio/intercepteur.dart';
import 'package:master_menu/model/commande.dart';
import 'package:master_menu/model/repat.dart';

class WebServices {
  late Dio dio;
  WebServices() {
    dio = Dio();
    // dio.interceptors
    //   .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
    dio.interceptors.add(CustomInterceptor());
  }

  //*************************************** */
  Future<dynamic> wsRegistration(
    String restName,
    String username,
    String password,
  ) async {
    String registUrl = "${baseUrl}register";

    try {
      Response response = await dio.post(registUrl, data: {
        'name_rest': restName,
        'password': password,
        'username': username,
      });
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //************************************************ */
  Future<dynamic> wschecklogin(String username, String password, String name,
      String mail, String fbToken) async {
    final box = GetStorage();
    String deviceId = box.read('DeviceId') ?? "";

    String loginUrl = "${baseUrl}login";
    if (mail.isNotEmpty) {
      username = "";
      password = "";
    }
    try {
      Response response = await dio.post(loginUrl, data: {
        'username': username,
        'password': password,
        'name': name,
        'deviceId': deviceId,
        'email': mail,
        'fb_token': fbToken,
      });

      return response.data;
    } on DioError catch (e) {
      print("${e.message}");
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

//*************************************** */
  Future<dynamic> wsGetListTable(int limit, int lastRecord) async {
    String mapsUrl = "${baseUrl}showTable";
    print(mapsUrl);
    try {
      Response response = await dio.get(mapsUrl,
          queryParameters: {"limit": limit, "last_record": lastRecord});

      return response.data;
    } on DioError catch (e) {
      print(e.message);
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsStoreTable(
      int id, String nom, int nbrChaise, bool status) async {
    String mapsUrl = "${baseUrl}addTable";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "id": id,
        "title": nom,
        "nbr_chaise": nbrChaise,
        "status": status
      });

      return response.data;
    } on DioError catch (e) {
      print(e.message);
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsDestroyTable(int id) async {
    String mapsUrl = "${baseUrl}deleteTable";

    try {
      Response response = await dio.post(mapsUrl, data: {"id": id});

      return response.data;
    } on DioError catch (e) {
      print(e.message);
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************************** */
  Future<dynamic> wsGetListUsers(int limit, int lastRecord) async {
    String mapsUrl = "${baseUrl}ShowUser";
    try {
      Response response = await dio.get(mapsUrl,
          queryParameters: {"limit": limit, "last_record": lastRecord});

      return response.data;
    } on DioError catch (e) {
      print(e.message);
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsStoreUser(
      int id, String username, String pass, String role) async {
    String mapsUrl = "${baseUrl}CreateUser";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "id": id,
        "username": username,
        "password": pass,
        "role": role
      });
      return response.data;
    } on DioError catch (e) {
      print(e.message);
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsDestroyUser(int id) async {
    String mapsUrl = "${baseUrl}deleteUser";

    try {
      Response response = await dio.post(mapsUrl, data: {"id": id});

      return response.data;
    } on DioError catch (e) {
      print(e.message);
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************************** */
  Future<dynamic> wsGetListCat(int limit, int lastRecord) async {
    String mapsUrl = "${baseUrl}showCat";
    try {
      Response response = await dio.get(mapsUrl,
          queryParameters: {"limit": limit, "last_record": lastRecord});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsStoreCat(
      int id, String title, String status, String photo) async {
    String mapsUrl = "${baseUrl}addCat";
    typeRequest = 1;

    FormData formData = FormData.fromMap(
        {"id": id, "title": title, "status": status, "image": photo});
    if (photo.isNotEmpty) {
      formData.files.add(MapEntry(
        "file",
        await MultipartFile.fromFile(
          photo,
          filename: 'image.jpg',

          // Set filename as you wish
        ),
      ));
    }

    try {
      Response response = await dio.post(mapsUrl, data: formData);
      typeRequest = 0;
      print("144 ${response.data}");
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsDeleteCat(int id) async {
    String mapsUrl = "${baseUrl}deleteCat";

    try {
      Response response = await dio.post(mapsUrl, data: {"id": id});
      return response.data;
    } on DioError catch (e) {
      print(e.message);
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************************** */
  Future<dynamic> wsGetListVariant(int idCat) async {
    String mapsUrl = "${baseUrl}showUnite";
    try {
      Response response =
          await dio.post(mapsUrl, queryParameters: {"cat_id": idCat});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsStoreVariant(int idCat, String title) async {
    String mapsUrl = "${baseUrl}addUnite";

    try {
      Response response =
          await dio.post(mapsUrl, data: {"cat_id": idCat, "title": title});
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsUpdateVariant(int idvariant, String title) async {
    String mapsUrl = "${baseUrl}updateUnite";

    try {
      Response response =
          await dio.post(mapsUrl, data: {"id": idvariant, "title": title});
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsDestroyVariant(int idVariant) async {
    String mapsUrl = "${baseUrl}deleteUnite";

    try {
      Response response = await dio.post(mapsUrl, data: {"id": idVariant});
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

//*************************************************** */
  Future<dynamic> wsGetListRepats(int idCat) async {
    String mapsUrl = "${baseUrl}showRepat";
    try {
      Response response =
          await dio.post(mapsUrl, queryParameters: {"cate_id": idCat});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsStoreRepat(int idCat, String title) async {
    String mapsUrl = "${baseUrl}addRepat";

    try {
      Response response = await dio
          .post(mapsUrl, data: {"cat_id": idCat, "title": title, "image": ""});
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  } //*************************************** */

  Future<dynamic> wsdetailRepat(
    int repatId,
  ) async {
    String mapsUrl = "${baseUrl}getDetailRepat";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "repatId": repatId,
      });
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
  //*************************************** */

  Future<dynamic> wsUpdateRepat(
      MRepat repat, String deleted, String photo) async {
    print("deleted ${repat.toJson()}");
    String mapsUrl = "${baseUrl}updateRepat";
    typeRequest = 1;

    FormData formData = FormData.fromMap({
      "repat": jsonEncode(repat.toJson()),
      "deleted": deleted,
    });
    print("zzz $photo");
    if (photo.isNotEmpty) {
      formData.files.add(MapEntry(
        "file",
        await MultipartFile.fromFile(
          photo,
          filename: 'image.jpg',

          // Set filename as you wish
        ),
      ));
    }

    try {
      Response response = await dio.post(mapsUrl, data: formData);
      typeRequest = 0;
      print("zzz ${response.data}");

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
  //*************************************** */
  // /deleteRepat

  Future<dynamic> wsDeleteRepatUnitet(
    int idRepatUnite,
  ) async {
    String mapsUrl = "${baseUrl}deleteRepatUnite";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "id": idRepatUnite,
      });
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
  //*************************************** */
  // /

  Future<dynamic> wsDeleteRepat(
    int idRepatUnite,
  ) async {
    String mapsUrl = "${baseUrl}deleteRepat";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "id": idRepatUnite,
      });
      print("result delete repat ${response.data}");
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
  //*************************************** */

  Future<dynamic> wsStoreRepatUnitet(
    int idUnite,
    int idRepat,
    int prix,
  ) async {
    String mapsUrl = "${baseUrl}storeRepatUnite";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "idUnite": idUnite,
        "idRepat": idRepat,
        "prix": prix,
      });
      print("resssult ${response.data}");
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
  //*************************************** */

  Future<dynamic> wsUpdateRepatVariant(
    String status,
    int idRepatVariant,
    int prix,
  ) async {
    String mapsUrl = "${baseUrl}updateRepatUnite";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "idRepatVariant": idRepatVariant,
        "status": status,
        "prix": prix
      });
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsLogout() async {
    String checkUrl = "${baseUrl}logout";

    try {
      Response response = await dio.post(checkUrl);

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

//*************************************** */
  Future<dynamic> wsGetCommandeByTable(int idTable) async {
    String checkUrl = "${baseUrl}getCommandeOfTable";
    // idTable = 3;

    try {
      Response response = await dio.post(checkUrl, data: {"table_id": idTable});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsStoreCommande(
      int table_id, MCommande commande, List<int> listDeleted) async {
    String checkUrl = "${baseUrl}addCommande";
    // idTable = 3;
    print("commande to json ${jsonEncode(commande.toJson())} ");

    try {
      Response response = await dio.post(checkUrl, data: {
        "table_id": table_id,
        "liste_deleted": listDeleted,
        "commande": jsonEncode(commande.toJson())
      });
      print("112 ${response.data}");

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsEncaissement(int idCommande) async {
    String checkUrl = "${baseUrl}encaissierCommande";
    try {
      Response response = await dio.post(checkUrl, data: {"id": idCommande});
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsDeleteCommande(int commande_id) async {
    String checkUrl = "${baseUrl}deleteCommande";
    // idTable = 3;

    try {
      Response response = await dio.post(checkUrl, data: {
        "id": commande_id,
      });
      print("112 ${response.data}");

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //-----------------------------------------------------------------------------------------/

  //**************************************** */
  Future<dynamic> getPromo() async {
    String url = "${baseUrl}get_promo";
    try {
      Response response = await dio.post(url, data: {});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsUploadImage(File imag) async {
    String loginUrl = "${baseUrl}update_photo";
    var formData =
        FormData.fromMap({'image': await MultipartFile.fromFile(imag.path)});

    try {
      Response response = await dio.post(loginUrl, data: formData);
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsAddFlashVente(
      String startAt, endAt, discount, nbrRepats) async {
    String loginUrl = "${baseUrl}flash-sale/store";

    try {
      Response response = await dio.post(loginUrl, data: {
        'start_at': startAt,
        'end_at': endAt,
        'discount': discount,
        'nbr_discount': nbrRepats,
      });

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsGetListPromo(int limit, int lastRecord) async {
    String mapsUrl = "${baseUrl}flash-sale";
    try {
      Response response = await dio.get(mapsUrl,
          queryParameters: {"limit": limit, "last_record": lastRecord});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //******************************************* */
  Future<dynamic> wsgetListTrans(int pageIndex) async {
    String loginUrl = "${baseUrl}transactions";

    try {
      Response response = await dio.get(
        loginUrl,
        queryParameters: {
          "limit": 10,
          "last_record": pageIndex,
        },
      );

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */

  Future<dynamic> wsGetListRecouv(int limit, int lastRecord) async {
    String mapsUrl = "${baseUrl}recouvrements";
    try {
      Response response = await dio.get(mapsUrl,
          queryParameters: {"limit": limit, "last_record": lastRecord});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
  //*************************************** */

  Future<dynamic> wsGetListBoire(int limit, int lastRecord) async {
    String mapsUrl = "${baseUrl}tips";
    try {
      Response response = await dio.get(mapsUrl,
          queryParameters: {"limit": limit, "last_record": lastRecord});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

//*************************************** */
  Future<dynamic> wsStoreTrans(int total, String qrcode) async {
    String mapsUrl = "${baseUrl}store_transaction";
    try {
      Response response = await dio.post(mapsUrl, data: {
        "token": "10",
        "total": total,
        "qrcode": qrcode,
      });

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsUpdateUser(int id, String username, String password,
      int type, int isActive, String permissions) async {
    String mapsUrl = "${baseUrl}utilisateurs/update";

    try {
      Response response = await dio.post(mapsUrl, data: {
        "id": id,
        "username": username,
        "password": password,
        "type": type,
        "is_active": isActive,
        "permissions": jsonDecode(permissions),
      });

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsGetDetailRecouv(
      String id, int limit, int lastRecord) async {
    String mapsUrl = "${baseUrl}detail_recouvrement/$id";
    try {
      Response response = await dio.get(mapsUrl,
          queryParameters: {"limit": limit, "last_record": lastRecord});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

//*************************************** */
  Future<dynamic> wsUpdateToken(String token) async {
    String mapsUrl = "${baseUrl}update_fcm_token";
    try {
      Response response = await dio.post(mapsUrl, data: {"fcm_token": token});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsGetListNotif(int last) async {
    String mapsUrl = "${baseUrl}notifications";
    try {
      Response response = await dio
          .get(mapsUrl, queryParameters: {"limit": 10, "last_record": last});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsDeleteUser(int id) async {
    String mapsUrl = "${baseUrl}utilisateurs/delete/${id}";
    try {
      Response response = await dio.get(mapsUrl, queryParameters: {});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsEditUser(int id) async {
    String mapsUrl = "${baseUrl}utilisateurs/edit/${id}";
    try {
      Response response = await dio.get(mapsUrl, queryParameters: {});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsGetProfile() async {
    String profileUrl = "${baseUrl}profile";

    try {
      Response response = await dio.get(profileUrl);

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
  //*************************************** */

  Future<dynamic> wsChangePassword(
      String email, String old, String nouv) async {
    String profileUrl = "${baseUrl}save_profile";

    try {
      Response response = await dio.post(profileUrl, data: {
        "old_password": old,
        "new_password": nouv,
        "confirm_password": nouv,
        "email": email,
      });

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //******************************************* */
  Future<dynamic> wsInitConfig() async {
    String ConfigUrl = "${baseUrl}init_settings";
    try {
      Response response = await dio.post(ConfigUrl,
          data: {},
          options: buildCacheOptions(
            const Duration(days: 7),
            forceRefresh: true,
          ));
      return response.data;
    } on DioError catch (e) {
      CommFunc.closeSession();

      return (<String, String>{
        "error": DioExceptions.fromDioError(e).message,
        "code": DioExceptions.fromDioError(e).message
      });
    }
  }

//------------------------------------------------------------------------------------------------------------

//******************************************* */
  Future<dynamic> wsgetPortail() async {
    String loginUrl = "${baseUrl}homepage";
    try {
      Response response = await dio.post(loginUrl,
          data: {},
          options: buildCacheOptions(
            Duration(days: 7),
            forceRefresh: true,
          ));
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */

  //*************************************** */
  Future<dynamic> wsGetDetailPartner(String id) async {
    String detailUrl = "${baseUrl}partner/${1}";
    try {
      Response response = await dio.get(
        detailUrl,
      );
      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsLoginGuest(String deviceId) async {
    String detailUrl = "${baseUrl}login_guest";

    try {
      Response response =
          await dio.get(detailUrl, queryParameters: {"device_id": deviceId});

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsGetPartners(int last) async {
    String partnerUrl = "${baseUrl}partners/?limit=10&last_record=$int";
    try {
      Response response = await dio.get(
        partnerUrl,
      );

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
//*************************************** */

  Future<dynamic> wsSaveProfile(String name, String tel) async {
    String profileUrl = "${baseUrl}save_profile";

    try {
      Response response = await dio.post(profileUrl, data: {
        "name": name,
        "tel": tel,
      });

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }

  //*************************************** */
  Future<dynamic> wsCheckUsername(String user) async {
    String checkUrl = "${baseUrl}check-username/$user";

    try {
      Response response = await dio.get(checkUrl);

      return response.data;
    } on DioError catch (e) {
      return (<String, String>{"error": DioExceptions.fromDioError(e).message});
    }
  }
}
