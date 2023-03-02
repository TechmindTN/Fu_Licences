class Ligue {
  int? id;
  String? created;
  String? name;

  Ligue({this.id, this.created, this.name});

  Ligue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    return data;
  }
}
