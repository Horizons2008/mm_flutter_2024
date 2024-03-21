class MVariant {
  MVariant({
    required this.id,
    required this.status,
    required this.prix,
    required this.title,
    required this.idRepatVariant,
    // required this.idRepatVariant,
  });
  late int id;
  late String status;
  late int prix;
  late String title;
  late int idRepatVariant;

  MVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    prix = json['prix'] ?? 0;
    title = json['title'];
    idRepatVariant = json['idRepatUnite'] ?? -1;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['prix'] = prix;
    _data['title'] = title;
    _data['idRepatUnite'] = idRepatVariant;

    return _data;
  }
}
