class Version {
  int? id;
  String? created;
  String? version;
  bool? latest;
  String? url;
  bool? valid;

  Version(
      {this.id, this.created, this.version, this.latest, this.url, this.valid});

  Version.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    version = json['version'];
    latest = json['latest'];
    url = json['url'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['version'] = this.version;
    data['latest'] = this.latest;
    data['url'] = this.url;
    data['valid'] = this.valid;
    return data;
  }
}
