class GetAllPassInfoModel {
  String? sId;
  String? user;
  String? website;
  String? password;
  List<PassInfoData>? data;
  bool? admin;
  List<Permissions>? permissions;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAllPassInfoModel(
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

  GetAllPassInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "N/A";

    user = json['user'] ?? "N/A";
    website = json['website'] ?? "N/A";
    password = json['password'] ?? "N/A";
   
    if (json['data'] != null) {
      data = <PassInfoData>[];
      json['data'].forEach((v) {
        data!.add(PassInfoData.fromJson(v));
      });
    }

    admin = json['admin'];

    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }

    createdAt = json['createdAt'] ?? "N/A";
    updatedAt = json['updatedAt'] ?? "N/A";
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

class PassInfoData {
  String? key;
  String? value;
  String? sId;

  PassInfoData({this.key, this.value, this.sId});

  PassInfoData.fromJson(Map<String, dynamic> json) {
    key = json['key'] ?? "N/A";
    value = json['value'] ?? "N/A";
    sId = json['_id'] ?? "N/A";
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
  User? user;
  bool? read;
  bool? write;
  bool? share;
  bool? delete;
  String? sId;

  Permissions(
      {this.user, this.read, this.write, this.share, this.delete, this.sId});

  Permissions.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null
        ? json['user'].runtimeType == String
            ? null
            : User.fromJson(json['user'])
        : null;
    read = json['read'];
    write = json['write'];
    share = json['share'];
    delete = json['delete'];
    sId = json['_id'] ?? "N/A";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['read'] = read;
    data['write'] = write;
    data['share'] = share;
    data['delete'] = delete;
    data['_id'] = sId;
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "N/A";
    name = json['name'] ?? "N/A";
    phnNumber = json['phnNumber'] ?? "N/A";
    email = json['email'] ?? "N/A";
    password = json['password'] ?? "N/A";
    isAdmin = json['isAdmin'];
    verified = json['verified'];
    createdAt = json['createdAt'] ?? "N/A";
    updatedAt = json['updatedAt'] ?? "N/A";
    iV = json['__v'];
    token = json['token'] ?? "N/A";
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
