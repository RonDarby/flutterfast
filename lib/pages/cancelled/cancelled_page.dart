import 'package:flutter/material.dart';

class CancelledPage extends StatefulWidget {
  static const route = '/cancelled';

  CancelledPage({Key key}) : super(key: key);

  @override
  _CancelledPageState createState() => _CancelledPageState();
}

class _CancelledPageState extends State<CancelledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Cancelled'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: _goToHome),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/images/logo.png')),
            Text('Such a pitty you cancelled!!!!!')
          ],
        ),
      ),
      // floatingActionButton: _bookmarkButton(),
    );
  }

  void _goToHome() {
    Navigator.of(context).pushReplacementNamed('/');
  }
}
