class UserModel {
  String? uid;
  String? email;

  UserModel({this.uid, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};
}
