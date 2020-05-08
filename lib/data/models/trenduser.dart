class Trenduser {
  String username;
  String name;
  String url;
  String avatar;
  Repo repo;

  Trenduser({this.username, this.name, this.url, this.avatar, this.repo});

  Trenduser.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    url = json['url'];
    avatar = json['avatar'];
    repo = json['repo'] != null ? new Repo.fromJson(json['repo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['url'] = this.url;
    data['avatar'] = this.avatar;
    if (this.repo != null) {
      data['repo'] = this.repo.toJson();
    }
    return data;
  }
}

class Repo {
  String name;
  String description;
  String url;

  Repo({this.name, this.description, this.url});

  Repo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['url'] = this.url;
    return data;
  }
}