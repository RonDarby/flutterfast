part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginSuccessEvent extends LoginEvent{}
class LoginFailedEvent extends LoginEvent{}