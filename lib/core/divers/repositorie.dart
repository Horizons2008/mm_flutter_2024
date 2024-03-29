import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:master_menu/core/divers/webservices.dart';
import 'package:master_menu/model/commande.dart';
import 'package:master_menu/model/repat.dart';

class Reposit {
  final WebServices ws;
  MCommande commande1 = MCommande(id: -1, total: 0, date: "", detail: []);

  Reposit(this.ws);
  Future rep_getPortail() async {
    return await ws.wsgetPortail();
  }

  //********************************** */
  Future rep_getTable(int last, int limite) async {
    return await ws.wsGetListTable(last, limite);
  }

  //********************************** */
  Future repSstoreTable(int id, String name, int nbrChaise, bool status) async {
    return await ws.wsStoreTable(id, name, nbrChaise, status);
  }

  //********************************** */
  Future repDestroyTable(int id) async {
    return await ws.wsDestroyTable(id);
  }

//********************************** */
  Future rep_getUser(int limit, int lastRecord) async {
    return await ws.wsGetListUsers(limit, lastRecord);
  }
  //**************************************************** */

  Future repStoreUser(
      int id, String username, String password, String role) async {
    return await ws.wsStoreUser(id, username, password, role);
  }
  //**************************************************** */

  Future repDestroyUser(int id) async {
    return await ws.wsDestroyUser(id);
  }

  //********************************** */
  Future rep_getCat(int limit, int lastRecord) async {
    return await ws.wsGetListCat(limit, lastRecord);
  }
  //**************************************************** */

  Future repStoreCat(int id, String title, String status, String photo) async {
    return await ws.wsStoreCat(id, title, status, photo);
  }
  //**************************************************** */

  Future repDeleteCat(int id) async {
    return await ws.wsDeleteCat(id);
  }

  //********************************** */
  Future rep_getListeVariant(int catId) async {
    return await ws.wsGetListVariant(catId);
  }
  //**************************************************** */

  Future repStoreVariant(int idCat, String title) async {
    return await ws.wsStoreVariant(idCat, title);
  }
  //**************************************************** */

  Future repUpdateVariant(int idCat, String title) async {
    return await ws.wsUpdateVariant(idCat, title);
  }
  //**************************************************** */

  Future repDestroyVariant(int idVariant) async {
    return await ws.wsDestroyVariant(idVariant);
  }

  //********************************** */
  Future rep_getListeRepat(int catId) async {
    return await ws.wsGetListRepats(catId);
  }
  //**************************************************** */

  Future repStoreRepat(int idCat, String title) async {
    return await ws.wsStoreRepat(idCat, title);
  }

  //********************************** */
  Future rep_getDetailRepat(int catId) async {
    return await ws.wsdetailRepat(catId);
  }

//********************************** */
  Future repUpdateRepat(MRepat repat, String deleted,String photo) async {
    return await ws.wsUpdateRepat(repat, deleted,photo);
  }

  //********************************** */
  Future repDeleteRepat(int id) async {
    return await ws.wsDeleteRepat(id);
  }

  //********************************** */
  Future repDeleteRepatUnite(int id) async {
    return await ws.wsDeleteRepatUnitet(id);
  }

  //********************************** */
  Future repStoreRepatUnite(int unite, int repat, int prix) async {
    return await ws.wsStoreRepatUnitet(unite, repat, prix);
  }

  //********************************** */
  Future repUpdateRepatVariant(
      String status, int idRepatVariant, int prix) async {
    return await ws.wsUpdateRepatVariant(status, idRepatVariant, prix);
  }

  //********************************** */
  Future rep_checkLogin(String username, String password, String name,
      String mail, String fb_token) async {
    return await ws.wschecklogin(username, password, name, mail, fb_token);
  }

  //********************************** */
  Future rep_deleteUser(int id) async {
    return await ws.wsDeleteUser(id);
  }

  //********************************** */
  Future rep_editUser(int id) async {
    return await ws.wsEditUser(id);
  }

  //**************************************************** */

  Future rep_updateUser(
    int id,
    String username,
    String password,
    int type,
    int isActive,
    String permissions,
  ) async {
    return await ws.wsUpdateUser(
        id, username, password, type, isActive, permissions);
  }

  //********************************** */
  Future rep_storeTrans(int total, String qrcode) async {
    return await ws.wsStoreTrans(total, qrcode);
  }

  //********************************** */
  Future rep_AddFlash(String start_at, end_at, discount, nbr_repats) async {
    return await ws.wsAddFlashVente(start_at, end_at, discount, nbr_repats);
  }

  //********************************** */
  Future rep_getListTrans(int ind) async {
    return await ws.wsgetListTrans(ind);
  }

  //********************************** */
  Future rep_getPromo() async {
    return await ws.getPromo();
  }

  //********************************** */
  Future rep_UpdateToken(String ind) async {
    return await ws.wsUpdateToken(ind);
  }

  //********************************** */
  Future rep_getListPromo(int limit, int last_record) async {
    return await ws.wsGetListPromo(limit, last_record);
  }

  //********************************** */
  Future rep_getListRecouv(int limit, int last_record) async {
    return await ws.wsGetListRecouv(limit, last_record);
  }

  //********************************** */
  Future rep_getListBoire(int limit, int last_record) async {
    return await ws.wsGetListBoire(limit, last_record);
  }

  //********************************** */
  Future rep_getDetailRecouv(String id, int limit, int last_record) async {
    return await ws.wsGetDetailRecouv(id, limit, last_record);
  }

  //********************************** */
  Future rep_getListNotif(int last) async {
    return await ws.wsGetListNotif(last);
  }

  /********************************** */
  Future rep_logout() async {
    return await ws.wsLogout();
  }

/********************************** */
  Future rep_getProfile() async {
    return await ws.wsGetProfile();
  }

/********************************** */
  Future rep_changePassword(String email, String old, nouv) async {
    return await ws.wsChangePassword(email, old, nouv);
  }

  //********************************** */
  Future rep_getConfig() async {
    return await ws.wsInitConfig();
  }

//********************************** */
  Future rep_getCommandeByIdTable(int id) async {
    commande1 = MCommande(id: -1, total: 0, date: "", detail: []);

    return await ws.wsGetCommandeByTable(id).then((value) => {
          if (value["commande"] != null)
            commande1 = MCommande.fromJson(value["commande"]),
        });
  }

  //********************************** */
  Future repStoreCommande(
      int idTable, MCommande commande, List<int> listeDeleted) async {
    return await ws.wsStoreCommande(idTable, commande, listeDeleted);
  }

  //********************************** */
  Future repEncaissementCommande(int idCommande) async {
    return await ws.wsEncaissement(idCommande);
  }

  //********************************** */
  Future repDeleteCommande(int id) async {
    return await ws.wsDeleteCommande(id);
  }

//---------------------------------------------------------------------------------------------------------------
  //********************************** */
  Future rep_registration(String rest_name, username, pass) async {
    return await ws.wsRegistration(rest_name, username, pass);
  }

  /********************************** */
  Future rep_saveProfile(String name, tel) async {
    return await ws.wsSaveProfile(name, tel);
  }

  /********************************** */
  Future rep_checkUser(String user) async {
    return await ws.wsCheckUsername(user);
  }

//********************************** */
  Future rep_getListPartner(int last) async {
    return await ws.wsGetPartners(last);
  }

  //********************************** */
  Future rep_getDetailPartner(String id) async {
    return await ws.wsGetDetailPartner(id);
  }

  //********************************** */
  Future rep_LoginGuest(String deviceId) async {
    return await ws.wsLoginGuest(deviceId);
  }
}
