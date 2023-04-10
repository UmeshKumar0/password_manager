class PermissionsUserModel {
  String? user;
  String? email;
  bool? read;
  bool? write;
  bool? share;
  bool? delete;
  String? sId;

  PermissionsUserModel(
      {this.user,
      this.read,
      this.write,
      this.email,
      this.share,
      this.delete,
      this.sId});

  PermissionsUserModel.fromJson(Map<String, dynamic> json) {
    user = json['name'];
    email = json['email'];

    read = json['read'];
    write = json['write'];
    share = json['share'];
    delete = json['delete'];
    sId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = user;
    data['email'] = email;

    data['read'] = read;
    data['write'] = write;
    data['share'] = share;
    data['delete'] = delete;
    data['userId'] = sId;
    return data;
  }
}
