class Grade {
  int? id;
  String? created;
  String? grade;

  Grade({this.id, this.created, this.grade});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    grade = json['Grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['Grade'] = this.grade;
    return data;
  }
}
