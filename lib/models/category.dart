class Category {
  int? id;
  String? created;
  String? categorieAge;
  int? min;
  int? max;

  Category({this.id, this.created, this.categorieAge, this.min, this.max});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    categorieAge = json['categorie_age'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['categorie_age'] = this.categorieAge;
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
