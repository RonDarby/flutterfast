import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payfast/pages/cancelled/cancelled_page.dart';
import 'package:payfast/pages/home_page/my_home_page.dart';
import 'package:payfast/pages/login/login_bloc.dart';
import 'package:payfast/pages/login/login_page.dart';
import 'package:payfast/pages/payfast/payfast_page.dart';
import 'package:payfast/pages/success/success_page.dart';
import 'package:payfast/services/auth/auth_bloc.dart';
import 'package:payfast/utils/colors.dart';
import 'package:payfast/pages/buy_now/buy_now_page.dart';
import 'package:payfast/initiators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _title = 'FlutterFast';
  ThemeData _theme = ThemeData(
    primarySwatch: pfpallete,
    backgroundColor: Color(0xFFFFFFFF),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    _configureRealTimePushNotifications() {
      final GoogleSignInAccount gUser = gSignIn.currentUser;

      firebaseMessaging.getToken().then((token) {
        usersReference
            .document(gUser.id)
            .updateData({"androidNotificationToken": token});
      });

      firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> msg) async {
          final String recipientId = msg["data"]["recipient"];
          final String body = msg["notification"]["body"];

          if (recipientId == gUser.id) {
            SnackBar snackBar = SnackBar(
              backgroundColor: Colors.grey,
              content: Text(
                body,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            );
            scaffoldKey.currentState.showSnackBar(snackBar);
          }
        },
      );
    }

    return BlocProvider(
        create: (_) => AuthBloc()..add(AuthStartedEvent()),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (_, AuthState state) {
          Widget homeWidget = Container();

          if (state is AuthUnauthenticatedState)
            homeWidget = GestureDetector(
                child: MaterialApp(
                    title: _title,
                    theme: _theme,
                    home: BlocProvider<LoginBloc>(
                        create: (_) => LoginBloc(), child: LoginPage())));
          else if (state is AuthAuthenticatedState) {
            _configureRealTimePushNotifications();
            homeWidget = GestureDetector(
                child: MaterialApp(
                    title: _title,
                    theme: _theme,
                    home: MyHomePage(title: 'FlutterFast'),
                    routes: <String, WidgetBuilder>{
                  '/buy_now': (BuildContext context) => BuyNowPage(),
                  PayFastExplorer.route: (BuildContext context) =>
                      PayFastExplorer(),
                  SuccessPage.route: (BuildContext context) => SuccessPage(),
                  CancelledPage.route: (BuildContext context) =>
                      CancelledPage(),
                }));
          }

          return homeWidget;
        }));
  }
}
