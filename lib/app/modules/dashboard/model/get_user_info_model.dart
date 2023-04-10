class GetUserInfoModel {
  String? msg;
  String? token;
  bool admin = false;
  String? name;
  String? email;
  String? phnNumber;
  String? userId;

  GetUserInfoModel({
    this.msg,
    this.token,
    this.admin = false,
    this.name,
    this.email,
    this.phnNumber,
    this.userId,
  });

  GetUserInfoModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    token = json['token'];
    admin = json['admin'];
    name = json['name'];
    email = json['email'];
    phnNumber = json['phnNumber'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['token'] = token;
    data['admin'] = admin;
    data['name'] = name;
    data['email'] = email;
    data['phnNumber'] = phnNumber;
    data['userId'] = userId;
    return data;
  }
}
