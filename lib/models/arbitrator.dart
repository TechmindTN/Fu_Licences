class Arbitrator {
  int? id;
  String? created;
  String? identityPhoto;
  String? photo;
  int? profile;
  int? grade;
  int? club;

  Arbitrator(
      {this.id,
      this.created,
      this.identityPhoto,
      this.photo,
      this.profile,
      this.grade,
      this.club});

  Arbitrator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    identityPhoto = json['identity_photo'];
    photo = json['photo'];
    profile = json['profile'];
    grade = json['grade'];
    club = json['club'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['identity_photo'] = this.identityPhoto;
    data['photo'] = this.photo;
    data['profile'] = this.profile;
    data['grade'] = this.grade;
    data['club'] = this.club;
    return data;
  }
}
