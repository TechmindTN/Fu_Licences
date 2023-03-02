class Profile {
  int? id;
  String? created;
  String? sexe;
  String? firstName;
  String? lastName;
  String? country;
  String? state;
  String? city;
  String? address;
  int? zipCode;
  String? profilePhoto;
  int? phone;
  String? location;
  String? birthday;
  String? cin;
  int? role;
  int? user;
  // Null? licences;

  Profile(
      {this.id,
      this.created,
      this.sexe,
      this.firstName,
      this.lastName,
      this.country,
      this.state,
      this.city,
      this.address,
      this.zipCode,
      this.profilePhoto,
      this.phone,
      this.location,
      this.birthday,
      this.cin,
      this.role,
      this.user
      // this.licences
      });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    sexe = json['sexe'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    zipCode = json['zip_code'];
    profilePhoto = json['profile_photo'];
    phone = json['phone'];
    location = json['location'];
    birthday = json['birthday'];
    cin = json['cin'];
    role = json['role'];
    user = json['user'];
    // licences = json['licences'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['sexe'] = this.sexe;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address'] = this.address;
    data['zip_code'] = this.zipCode;
    data['profile_photo'] = this.profilePhoto;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['birthday'] = this.birthday;
    data['cin'] = this.cin;
    data['role'] = this.role;
    data['user'] = this.user;
    // data['licences'] = this.licences;
    return data;
  }
}
