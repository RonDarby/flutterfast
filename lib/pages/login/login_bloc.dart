import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:payfast/initiators.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSuccessEvent)
      yield* _mapLoginSuccessEvent();
    else if (event is LoginFailedEvent)
      yield* _mapLoginFailedEvent();
  }

  saveUserInfoToFireStore() async {
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot = await usersReference.document(gCurrentUser.id).get();

    if(!documentSnapshot.exists){
      usersReference.document(gCurrentUser.id).setData({
        "id": gCurrentUser.id,
        "profileName": gCurrentUser.displayName,
        "imageUrl": gCurrentUser.photoUrl,
        "email": gCurrentUser.email,
        "bio": "",
        "timestamp": DateTime.now(),
      });

    }

  }

  Stream<LoginState> _mapLoginFailedEvent() async*{
    yield state.update(isSuccess: true, isValid: false);
  }
  Stream<LoginState> _mapLoginSuccessEvent() async*{
    await saveUserInfoToFireStore();
    yield state.update(isValid: true,isSuccess: true);
  }
}
