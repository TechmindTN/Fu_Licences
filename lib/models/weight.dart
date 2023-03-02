class Weight {
  int? id;
  String? created;
  int? masseEnKillograme;
  int? min;
  int? max;

  Weight({this.id, this.created, this.masseEnKillograme, this.min, this.max});

  Weight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    masseEnKillograme = json['masse_en_killograme'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['masse_en_killograme'] = this.masseEnKillograme;
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
