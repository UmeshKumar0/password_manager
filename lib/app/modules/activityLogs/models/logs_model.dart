class LogsModel {
  String? sId;
  String? level;
  String? message;
  Metadata? metadata;
  User? user;
  String? createdAt;
  String? updatedAt;

  LogsModel(
      {this.sId,
      this.level,
      this.message,
      this.metadata,
      this.user,
      this.createdAt,
      this.updatedAt});

  LogsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    level = json['level'];
    message = json['message'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['level'] = level;
    data['message'] = message;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Metadata {
  List<Action>? action;

  Metadata({this.action});

  Metadata.fromJson(Map<String, dynamic> json) {
    if (json['action'] != null) {
      action = <Action>[];
      json['action'].forEach((v) {
        action!.add(new Action.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (action != null) {
      data['action'] = action!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Action {
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
  String? name;
  String? phnNumber;
  String? email;
  bool? isAdmin;
  bool? verified;
  String? token;

  Action(
      {this.sId,
      this.user,
      this.website,
      this.password,
      this.data,
      this.admin,
      this.permissions,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.name,
      this.phnNumber,
      this.email,
      this.isAdmin,
      this.verified,
      this.token});

  Action.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    website = json['website'];
    password = json['password'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    admin = json['admin'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    name = json['name'];
    phnNumber = json['phnNumber'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    verified = json['verified'];
    token = json['token'];
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
    data['name'] = name;
    data['phnNumber'] = phnNumber;
    data['email'] = email;
    data['isAdmin'] = isAdmin;
    data['verified'] = verified;
    data['token'] = token;
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

  User({this.sId, this.name, this.phnNumber, this.email});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phnNumber = json['phnNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phnNumber'] = phnNumber;
    data['email'] = email;
    return data;
  }
}
