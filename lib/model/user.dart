class MUser {
  MUser({
    required this.id,
    required this.photos,
    required this.role,
    required this.status,
    required this.username,
  });
  late final String username;
  late int id;
  late final String role;
  late String status;
  late String photos;

  MUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
    status = json['status'];
    photos = json['photos'] ?? "";
  }

  /* Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['rest_id'] = rest_id;
    _data['rest_name'] = rest_name;
    _data['token'] = token;
    return _data;
  }*/
}
