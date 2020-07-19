part of 'login_bloc.dart';

class LoginState {
  final bool isValid;
  final bool isLoading;
  final bool isSuccess;
  final String error;

  LoginState({
    @required this.isValid,
    @required this.isLoading,
    @required this.isSuccess,
    @required this.error
  });

  factory LoginState.initial({
    bool isValid
  }) {
    return LoginState(
        isValid: isValid ?? false,
        isLoading: false,
        isSuccess: false,
        error: ''
    );
  }

  LoginState update({
    bool isValid,
    bool isLoading,
    bool isSuccess,
    String error
  }) {
    return LoginState(
        isValid: isValid ?? this.isValid,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        error: error ?? this.error
    );
  }
}
