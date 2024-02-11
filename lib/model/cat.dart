class MCat {
  MCat({
    required this.id,
    required this.image,
    required this.title,
    required this.status,
  });
  late final String title;
  late int id;
  late final String image;
  late String status;

  MCat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
  }
}
