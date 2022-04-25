import 'package:diplom/authentication/authentication_repository.dart';
import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/widjects/app.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}