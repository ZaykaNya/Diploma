import 'dart:convert';

class User {
  final UserInfo user;
  final List<dynamic> courses;
  final List<dynamic> branches;

  const User({
    required this.user,
    required this.courses,
    required this.branches,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user: UserInfo.fromJson(json['user']),
      courses: json['courses'],
      branches: json['branches'],
    );
  }
}

List<UserInfo> postFromJson(String str) =>
    List<UserInfo>.from(json.decode(str).map((x) => UserInfo.fromMap(x)));

class UserInfo {
  final String id;
  final String name;
  final String surname;
  final String login;

  const UserInfo({
    required this.id,
    required this.name,
    required this.surname,
    required this.login,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      login: json['login'],
    );
  }

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
    id: json['id'],
    name: json['name'],
    surname: json['surname'],
    login: json['login'],
  );
}