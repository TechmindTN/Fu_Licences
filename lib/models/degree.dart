class Degree {
  int? id;
  String? created;
  String? degree;

  Degree({this.id, this.created, this.degree});

  Degree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    degree = json['Degree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['Degree'] = this.degree;
    return data;
  }
}
