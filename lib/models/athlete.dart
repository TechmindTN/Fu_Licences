class Athlete {
  int? id;
  String? created;
  dynamic? categoryId;
  dynamic? gradeId;
  dynamic? idDegree;
  String? photo;
  String? identityPhoto;
  String? medicalPhoto;
  dynamic? discipline;
  dynamic? profile;
  dynamic? weights;
  dynamic? club;

  Athlete(
      {this.id,
      this.created,
      this.categoryId,
      this.gradeId,
      this.idDegree,
      this.photo,
      this.identityPhoto,
      this.medicalPhoto,
      this.discipline,
      this.profile,
      this.weights,
      this.club});

  Athlete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    categoryId = json['category_id'];
    gradeId = json['grade_id'];
    idDegree = json['id_degree'];
    photo = json['photo'];
    identityPhoto = json['identity_photo'];
    medicalPhoto = json['medical_photo'];
    discipline = json['discipline'];
    profile = json['profile'];
    weights = json['weights'];
    club = json['club'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['category_id'] = this.categoryId;
    data['grade_id'] = this.gradeId;
    data['id_degree'] = this.idDegree;
    data['photo'] = this.photo;
    data['identity_photo'] = this.identityPhoto;
    data['medical_photo'] = this.medicalPhoto;
    data['discipline'] = this.discipline;
    data['profile'] = this.profile;
    data['weights'] = this.weights;
    data['club'] = this.club;
    return data;
  }
}
