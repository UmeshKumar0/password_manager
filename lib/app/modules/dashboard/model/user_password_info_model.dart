class UserPasswordInfoModel {
  String? sId;
  String? user;
  String? website;
  String? password;
  String? createdAt;

  UserPasswordInfoModel(
      {this.sId, this.user, this.website, this.password, this.createdAt});

  UserPasswordInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    website = json['website'];
    password = json['password'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['website'] = website;
    data['password'] = password;
    data['createdAt'] = createdAt;
    return data;
  }
}
