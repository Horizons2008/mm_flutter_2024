class Utilisateur {
  Utilisateur(
      {required this.token,
      required this.rest_id,
      required this.rest_name,
      required this.role,
      required this.username});
  late final String token;
  late int rest_id;
  late final String rest_name;
  late String role;
  late String username;

  Utilisateur.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    rest_id = json['rest_id'];
    rest_name = json['rest_name'];
    role = json['role'];
    username = json['username'];
    switch (json['role']) {
      case "S":
        role = "Serveur";
        break;
      case "A":
        role = "Admin";
        break;
      case "C":
        role = "Caissier";
        break;
    }
    
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
