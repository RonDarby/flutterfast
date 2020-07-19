import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payfast/initiators.dart';
import 'package:payfast/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  User user;


  AuthBloc() : super(AuthUninitializedState());

  currentUser() async{
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    if(this.user == null){
      DocumentSnapshot documentSnapshot = await usersReference.document(gCurrentUser.id).get();
      this.user = User.fromDocument(documentSnapshot);
    }
  }

  @override
  Stream<AuthState> mapEventToState(
      AuthEvent event,
      ) async* {
    if (event is AuthStartedEvent)
      yield* _mapStartedToState();
    else if (event is AuthLoggedInEvent)
      yield* _mapLoggedInToState(event);
    else if (event is AuthLoggedOutEvent)
      yield* _mapLoggedOutToState();
  }

  Stream<AuthState> _mapStartedToState() async* {
    if (gSignIn.currentUser != null)
      yield AuthAuthenticatedState();
    else yield AuthUnauthenticatedState();
  }

  Stream<AuthState> _mapLoggedInToState(AuthLoggedInEvent event) async* {
    currentUser();
    yield AuthAuthenticatedState();
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    gSignIn.signOut();
    yield AuthUnauthenticatedState();
  }
}