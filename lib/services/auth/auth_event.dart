part of 'auth_bloc.dart';


abstract class AuthEvent {}

class AuthStartedEvent extends AuthEvent {}

class AuthLoggedInEvent extends AuthEvent {
  final GoogleSignInAccount currentUser;
  AuthLoggedInEvent({@required this.currentUser});
}

class AuthLoggedOutEvent extends AuthEvent {}
