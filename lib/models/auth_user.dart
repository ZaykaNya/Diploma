import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String? login;
  final String? role;
  final String id;

  const AuthUser({
    required this.login,
    required this.role,
    required this.id,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      login: json['login'],
      role: json['role'],
      id: json['id'],
    );
  }

  @override
  List<Object> get props => [id];

  static const empty = AuthUser(id: '-', login: "-", role: "-");
}