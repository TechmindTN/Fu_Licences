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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num_licences'] = this.numLicences;
    data['created'] = this.created;
    data['activated'] = this.activated;
    // data['state'] = this.state;
    data['verified'] = this.verified;
    data['user'] = this.user;
    data['role'] = this.role;
    data['seasons'] = this.seasons;
    data['degree'] = this.degree;
    data['grade'] = this.grade;
    data['weight'] = this.weight;
    data['categorie'] = this.categorie;
    data['club'] = this.club;
    data['discipline'] = this.discipline;
    return data;
  }
}
