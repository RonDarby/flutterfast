import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  static const route = '/success';

  SuccessPage({Key key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: _goToHome),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/images/logo.png')),
            Text('Awesome, thanks for your payment!!!!')
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
