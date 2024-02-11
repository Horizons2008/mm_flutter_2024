class MTable {
  MTable({
    required this.id,
    required this.name,
    required this.nbr_chaise,
    required this.status,
    required this.count_order,
    required this.montant,
  });
  late final String name;
  late int id;
  late final String nbr_chaise;
  late String status;
  late int count_order;
  late int montant;

  MTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
    nbr_chaise = json['nbr_chaise'];
    status = json['status'];
    count_order = json['count_order'] ?? 0;
    montant = json['montant'] ?? 0;
  }

  /* Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['rest_id'] = rest_id;
    _data['rest_name'] = rest_name;
    _data['token'] = token;
    return _data;
  }*/
}
