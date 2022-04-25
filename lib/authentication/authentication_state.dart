import 'package:diplom/authentication/authentication_repository.dart';
import 'package:diplom/models/auth_user.dart';
import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = AuthUser.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(AuthUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final AuthUser user;

  @override
  List<Object> get props => [status, user];
}