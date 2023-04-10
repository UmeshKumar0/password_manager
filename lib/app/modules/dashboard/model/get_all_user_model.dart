import 'dart:convert';

class GetAllUserModel {
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

  GetAllUserModel(
      {this.sId,
      this.name,
      this.phnNumber,
      this.email,
      this.password,
      this.isAdmin,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetAllUserModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

List<GetAllUserModel> getAllUserModelFromJson(String str) =>
    List<GetAllUserModel>.from(
        jsonDecode(str).map((x) => GetAllUserModel.fromJson(x)));
