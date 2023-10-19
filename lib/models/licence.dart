class Licence {
  String? numLicences;
  String? created;
  bool? activated;
  String? state;
  bool? verified;
  int? user;
  dynamic role;
  dynamic seasons;
  dynamic degree;
  dynamic grade;
  dynamic weight;
  dynamic categorie;
  dynamic club;
  dynamic discipline;

  Licence(
      {this.numLicences,
      this.created,
      this.activated,
      this.state,
      this.verified,
      this.user,
      this.role,
      this.seasons,
      this.degree,
      this.grade,
      this.weight,
      this.categorie,
      this.club,
      this.discipline});

  Licence.fromJson(Map<String, dynamic> json) {
    numLicences = json['num_licences'];
    created = json['created'];
    activated = json['activated'];
    state = json['state'];
    verified = json['verified'];
    user = json['user'];
    role = json['role'];
    seasons = json['seasons'];
    degree = json['degree'];
    grade = json['grade'];
    weight = json['weight'];
    categorie = json['categorie'];
    club = json['club'];
    discipline = json['discipline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num_licences'] = numLicences;
    data['created'] = created;
    data['activated'] = activated;
    // data['state'] = this.state;
    data['verified'] = verified;
    data['user'] = user;
    data['role'] = role;
    data['seasons'] = seasons;
    data['degree'] = degree;
    data['grade'] = grade;
    data['weight'] = weight;
    data['categorie'] = categorie;
    data['club'] = club;
    data['discipline'] = discipline;
    return data;
  }
}
