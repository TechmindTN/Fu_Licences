class Stats {
  int? athletes;
  int? coaches;
  int? arbitrators;
  int? supporters;
  int? clubs;
  int? activeLicences;
  int? pendingLicences;
  int? expiredLicences;
  AthletesLicences? athletesLicences;
  AthletesLicences? coachesLicences;
  AthletesLicences? arbitratorsLicences;
  AthletesLicences? supportersLicences;
  Users? users;

  Stats(
      {this.athletes,
      this.coaches,
      this.arbitrators,
      this.supporters,
      this.clubs,
      this.activeLicences,
      this.pendingLicences,
      this.expiredLicences,
      this.athletesLicences,
      this.coachesLicences,
      this.arbitratorsLicences,
      this.supportersLicences,
      this.users});

  Stats.fromJson(Map<String, dynamic> json) {
    athletes = json['athletes'];
    coaches = json['coaches'];
    arbitrators = json['arbitrators'];
    supporters = json['supporters'];
    clubs = json['clubs'];
    activeLicences = json['active_licences'];
    pendingLicences = json['pending_licences'];
    expiredLicences = json['expired_licences'];
    athletesLicences = json['athletes_licences'] != null
        ? new AthletesLicences.fromJson(json['athletes_licences'])
        : null;
    coachesLicences = json['coaches licences'] != null
        ? new AthletesLicences.fromJson(json['coaches licences'])
        : null;
    arbitratorsLicences = json['arbitrators licences'] != null
        ? new AthletesLicences.fromJson(json['arbitrators licences'])
        : null;
    supportersLicences = json['supporters licences'] != null
        ? new AthletesLicences.fromJson(json['supporters licences'])
        : null;
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['athletes'] = this.athletes;
    data['coaches'] = this.coaches;
    data['arbitrators'] = this.arbitrators;
    data['supporters'] = this.supporters;
    data['clubs'] = this.clubs;
    data['active_licences'] = this.activeLicences;
    data['pending_licences'] = this.pendingLicences;
    data['expired_licences'] = this.expiredLicences;
    if (this.athletesLicences != null) {
      data['athletes_licences'] = this.athletesLicences!.toJson();
    }
    if (this.coachesLicences != null) {
      data['coaches licences'] = this.coachesLicences!.toJson();
    }
    if (this.arbitratorsLicences != null) {
      data['arbitrators licences'] = this.arbitratorsLicences!.toJson();
    }
    if (this.supportersLicences != null) {
      data['supporters licences'] = this.supportersLicences!.toJson();
    }
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class AthletesLicences {
  int? total;
  int? active;
  int? pending;
  int? expired;

  AthletesLicences({this.total, this.active, this.pending, this.expired});

  AthletesLicences.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    active = json['active'];
    pending = json['pending'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['active'] = this.active;
    data['pending'] = this.pending;
    data['expired'] = this.expired;
    return data;
  }
}

class Users {
  int? total;
  int? active;
  int? inactive;
  int? staff;
  int? admins;

  Users({this.total, this.active, this.inactive, this.staff, this.admins});

  Users.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    active = json['active'];
    inactive = json['inactive'];
    staff = json['staff'];
    admins = json['admins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['active'] = this.active;
    data['inactive'] = this.inactive;
    data['staff'] = this.staff;
    data['admins'] = this.admins;
    return data;
  }
}
