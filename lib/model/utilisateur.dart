class Utilisateur {
  Utilisateur({
    required this.token,
    required this.rest_id,
    required this.rest_name,
    required this.role,
  });
  late final String token;
  late int rest_id;
  late final String rest_name;
  late String role;

  Utilisateur.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    rest_id = json['rest_id'];
    rest_name = json['rest_name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['rest_id'] = rest_id;
    _data['rest_name'] = rest_name;
    _data['token'] = token;
    _data['role'] = role;

    return _data;
  }
}
