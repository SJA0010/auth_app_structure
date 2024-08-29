// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? userName;
  String userid;
  String? email;
  String? password;
  String? phone;
  UserModel({
    this.userName,
    required this.userid,
    this.email,
    this.password,
    this.phone,
  });

  UserModel copyWith({
    String? userName,
    String? userid,
    String? email,
    String? password,
    String? phone,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      userid: userid ?? this.userid,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userid': userid,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] != null ? map['userName'] as String : null,
      userid: map['userid'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userName: $userName, userid: $userid, email: $email, password: $password, phone: $phone)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.userid == userid &&
        other.email == email &&
        other.password == password &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        userid.hashCode ^
        email.hashCode ^
        password.hashCode ^
        phone.hashCode;
  }
}
