class Coach {
  int? id;
  String? created;
  String? identityPhoto;
  String? degreePhoto;
  String? gradePhoto;
  String? photo;
  dynamic? profile;
  dynamic? grade;
  dynamic? degree;
  dynamic? club;
  dynamic? categoryId;
  dynamic? weights;
  dynamic? category;
  dynamic? discipline;

  Coach(
      {this.id,
      this.created,
      this.identityPhoto,
      this.degreePhoto,
      this.gradePhoto,
      this.photo,
      this.profile,
      this.grade,
      this.degree,
      this.club,
      this.categoryId,
      this.weights,
      this.category,
      this.discipline});

  Coach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    identityPhoto = json['identity_photo'];
    degreePhoto = json['degree_photo'];
    gradePhoto = json['grade_photo'];
    photo = json['photo'];
    profile = json['profile'];
    grade = json['grade'];
    degree = json['degree'];
    club = json['club'];
    categoryId = json['category_id'];
    weights = json['weights'];
    category = json['category'];
    discipline = json['discipline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['identity_photo'] = this.identityPhoto;
    data['degree_photo'] = this.degreePhoto;
    data['grade_photo'] = this.gradePhoto;
    data['photo'] = this.photo;
    data['profile'] = this.profile;
    data['grade'] = this.grade;
    data['degree'] = this.degree;
    data['club'] = this.club;
    data['category_id'] = this.categoryId;
    data['weights'] = this.weights;
    data['category'] = this.category;
    data['discipline'] = this.discipline;
    return data;
  }
}
