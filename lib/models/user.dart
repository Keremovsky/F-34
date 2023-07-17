// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String registerType;
  final double money;
  final double savedMoney;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.registerType,
    required this.money,
    required this.savedMoney,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? registerType,
    double? money,
    double? savedMoney,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      registerType: registerType ?? this.registerType,
      money: money ?? this.money,
      savedMoney: savedMoney ?? this.savedMoney,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'registerType': registerType,
      'money': money,
      'savedMoney': savedMoney,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      registerType: map['registerType'] as String,
      money: map['money'] as double,
      savedMoney: map['savedMoney'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, registerType: $registerType, money: $money, savedMoney: $savedMoney)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.registerType == registerType &&
        other.money == money &&
        other.savedMoney == savedMoney;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        registerType.hashCode ^
        money.hashCode ^
        savedMoney.hashCode;
  }
}
