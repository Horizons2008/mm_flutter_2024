import 'package:master_menu/model/variant.dart';

class MRepat {
  MRepat({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
    required this.catId,
    required this.variants,
  });
  late final int id;
  late String title;
  late final String image;
  late final String status;
  late String inOrder;

  late final int catId;
  late final List<MVariant> variants;

  MRepat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
    catId = json['categorie_id'];
    inOrder = "";

    variants = List.from(json['variant'] ?? [])
        .map((e) => MVariant.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['status'] = status;
    _data['categorie_id'] = catId;
    _data['variant'] = variants.map((e) => e.toJson()).toList();
    return _data;
  }
}
