class User {
  int? id;
  bool? isSuperuser;
  String? username;
  bool? isStaff;
  bool? isActive;
  DateTime? dateJoined;
  String? password;

  User(
      {this.id,
      this.isSuperuser,
      this.username,
      this.isStaff,
      this.isActive,
      this.dateJoined,
      this.password
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_superuser'] = this.isSuperuser;
    data['username'] = this.username;
    data['is_staff'] = this.isStaff;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['password'] = this.password;

    return data;
  }
}
