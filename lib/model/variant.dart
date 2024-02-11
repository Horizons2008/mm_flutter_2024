class MVariant {
  MVariant({
    required this.id,
    required this.status,
    required this.prix,
    required this.title,
  });
  late int id;
  late String status;
  late int prix;
  late String title;

  MVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    prix = json['prix'] ?? 0;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['prix'] = prix;
    _data['title'] = title;
    return _data;
  }
}
