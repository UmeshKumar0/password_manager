class GetAllLogsModel {
  String? sId;
  String? level;
  String? message;
  Metadata? metadata;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAllLogsModel(
      {this.sId,
      this.level,
      this.message,
      this.metadata,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetAllLogsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    level = json['level'];
    message = json['message'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['level'] = level;
    data['message'] = message;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Metadata {
  DeletePassword? deletePassword;
  User? user;

  Metadata({this.deletePassword, this.user});

  Metadata.fromJson(Map<String, dynamic> json) {
    deletePassword = json['deletePassword'] != null
        ? DeletePassword.fromJson(json['deletePassword'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deletePassword != null) {
      data['deletePassword'] = deletePassword!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class DeletePassword {
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

  DeletePassword(
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

  DeletePassword.fromJson(Map<String, dynamic> json) {
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
