class Club {
  int? id;
  String? created;
  String? name;
  String? logo;
  int? profile;
  int? ligue;

  Club({this.id, this.created, this.name, this.logo, this.profile, this.ligue});

  Club.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    name = json['name'];
    logo = json['logo'];
    profile = json['profile'];
    ligue = json['ligue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['profile'] = this.profile;
    data['ligue'] = this.ligue;
    return data;
  }
}
