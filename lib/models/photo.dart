class Photo {
  int? id;
  String? url;
  String? path;
  int? size;
  String? name;
  String? extension;
  Null? type;
  String? uploaded;
  int? season;
  int? user;

  Photo(
      {this.id,
      this.url,
      this.path,
      this.size,
      this.name,
      this.extension,
      this.type,
      this.uploaded,
      this.season,
      this.user});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    path = json['path'];
    size = json['size'];
    name = json['name'];
    extension = json['extension'];
    type = json['type'];
    uploaded = json['uploaded'];
    season = json['season'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['path'] = this.path;
    data['size'] = this.size;
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['type'] = this.type;
    data['uploaded'] = this.uploaded;
    data['season'] = this.season;
    data['user'] = this.user;
    return data;
  }
}
