class MCommande {
  MCommande({
    required this.id,
    required this.total,
    required this.date,
    required this.detail,
  });
  late final int id;
  late int total;
  late final String date;
  late List<MDetail> detail;

  MCommande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    detail = List.from(json['detail']).map((e) => MDetail.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['totla'] = total;
    _data['date'] = date;
    _data['detail'] = detail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class MDetail {
  MDetail({
    required this.titleRepat,
    required this.titleVariant,
    required this.prixRepat,
    required this.qte,
    required this.sousTotal,
    required this.id,
    required this.idRepatUnite,
  });
  late int id;

  late String titleRepat;
  late String titleVariant;
  late int prixRepat;
  late int qte;
  late int sousTotal;
  late int idRepatUnite;

  MDetail.fromJson(Map<String, dynamic> json) {
    titleRepat = json['title_repat'];
    titleVariant = json['title_variant'];
    prixRepat = json['prix_repat'];
    qte = json['qte'];
    sousTotal = json['sous_total'];
    id = json['id'];
    idRepatUnite = json['repat_variant_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title_repat'] = titleRepat;
    _data['title_variant'] = titleVariant;
    _data['prix_repat'] = prixRepat;
    _data['qte'] = qte;
    _data['sous_total'] = sousTotal;
    _data['id'] = id;
    _data['idRepatUnite'] = idRepatUnite;

    return _data;
  }
}
