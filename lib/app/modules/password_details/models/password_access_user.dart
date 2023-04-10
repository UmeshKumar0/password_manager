class PasswordAccessUser {
  String? sId;
  String? name;
  String? phnNumber;
  String? email;
  String? password;
  bool? isAdmin;
  bool? verified;

  PasswordAccessUser(
      {this.sId,
      this.name,
      this.phnNumber,
      this.email,
      this.password,
      this.isAdmin,
      this.verified});

  PasswordAccessUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phnNumber = json['phnNumber'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
    verified = json['verified'];
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
    return data;
  }
}
