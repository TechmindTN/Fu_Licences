class Season {
  int? id;
  String? created;
  String? seasons;
  bool? activated;

  Season({this.id, this.created, this.seasons, this.activated});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    seasons = json['Seasons'];
    activated = json['activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['Seasons'] = this.seasons;
    data['activated'] = this.activated;
    return data;
  }
}
