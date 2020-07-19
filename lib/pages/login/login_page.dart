import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payfast/initiators.dart';
import 'package:payfast/pages/login/login_bloc.dart';
import 'package:payfast/services/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  void _blocListener(context, state) {
    if (state.isLoading) {
    }
    // _loading = Loading(context);
    else if (state.isValid) {
      final GoogleSignInAccount gUser = gSignIn.currentUser;
      BlocProvider.of<AuthBloc>(context).add(AuthLoggedInEvent(currentUser: gUser));
    } else if (state.error.isNotEmpty) {
      // _loading.close();
      // SnackbarWithColor(context: context, text: state.error, color: Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    gSignIn.onCurrentUserChanged.listen((gSigninAccount){
      _controlSignIn(gSigninAccount);
    }, onError: (gError){
      print("Error Message: " + gError.toString());
    });

    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount){
      _controlSignIn(gSignInAccount);
    }).catchError((gError){
      print("Error Message: " + gError.toString());
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
            listener: _blocListener,
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (_, state) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).accentColor,
                      Theme.of(context).primaryColor
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _loginUser,
                      child: Container(
                        width: 270.0,
                        height: 65.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/google_signin_button.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  _loginUser() {
    gSignIn.signIn();
  }

  _controlSignIn(GoogleSignInAccount signInAccount) async
  {
    if(signInAccount != null)
    {
       _loginBloc.add(LoginSuccessEvent());
    }
    else
    {
      _loginBloc.add(LoginFailedEvent());
    }
  }
}
