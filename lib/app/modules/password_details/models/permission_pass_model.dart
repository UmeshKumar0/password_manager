class GetPassPermissionModel {
  String? msg;
  List<Info>? info;
  InfoPassword? infoPassword;

  GetPassPermissionModel({this.msg, this.info, this.infoPassword});

  GetPassPermissionModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['info'] != null) {
      info = <Info>[];
      json['info'].forEach((v) {
        info!.add(Info.fromJson(v));
      });
    }
    infoPassword = json['infoPassword'] != null
        ? InfoPassword.fromJson(json['infoPassword'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (info != null) {
      data['info'] = info!.map((v) => v.toJson()).toList();
    }
    if (infoPassword != null) {
      data['infoPassword'] = infoPassword!.toJson();
    }
    return data;
  }
}

class Info {
  String? sId;
  String? name;
  String? phnNumber;
  String? email;
  String? password;
  bool? isAdmin;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? token;

  Info(
      {this.sId,
      this.name,
      this.phnNumber,
      this.email,
      this.password,
      this.isAdmin,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.token});

  Info.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phnNumber = json['phnNumber'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
    verified = json['verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phnNumber'] = phnNumber;
    data['email'] = email;
    data['password'] = password;
    data['isAdmin'] = isAdmin;
    data['verified'] = verified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['token'] = token;
    return data;
  }
}

class InfoPassword {
  String? sId;
  String? user;
  String? website;
  String? password;
  List<Data>? data;
  bool? admin;
  List<Permissions>? permissions;
  String? createdAt;
  String? updatedAt;
  int? iV;

  InfoPassword(
      {this.sId,
      this.user,
      this.website,
      this.password,
      this.data,
      this.admin,
      this.permissions,
      this.createdAt,
      this.updatedAt,
      this.iV});

  InfoPassword.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    website = json['website'];
    password = json['password'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    admin = json['admin'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['website'] = website;
    data['password'] = password;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['admin'] = admin;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Data {
  String? key;
  String? value;
  String? sId;

  Data({this.key, this.value, this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    data['_id'] = sId;
    return data;
  }
}

class Permissions {
  String? user;
  bool? read;
  bool? write;
  bool? share;
  bool? delete;
  String? sId;

  Permissions(
      {this.user, this.read, this.write, this.share, this.delete, this.sId});

  Permissions.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    read = json['read'];
    write = json['write'];
    share = json['share'];
    delete = json['delete'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['read'] = read;
    data['write'] = write;
    data['share'] = share;
    data['delete'] = delete;
    data['_id'] = sId;
    return data;
  }
}
