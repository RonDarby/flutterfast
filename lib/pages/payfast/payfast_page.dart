import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payfast/pages/cancelled/cancelled_page.dart';
import 'package:payfast/pages/success/success_page.dart';
import 'package:payfast/utils/config.dart';
import 'package:payfast/utils/screen_arguments.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path/path.dart' as p;

class PayFastExplorer extends StatefulWidget {
  static const route = '/payfast';

  @override
  _PayFastExplorerState createState() => _PayFastExplorerState();
}

class _PayFastExplorerState extends State<PayFastExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Payment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _goToHome,
        ),
      ),
      body: WebView(
        debuggingEnabled: true,
        initialUrl: Configs.domain + '?post=' + args.body,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
              name: "locationChanged",
              onMessageReceived: (JavascriptMessage message) {
                Navigator.of(context).pushReplacementNamed(message.message);
              }),
        ]),
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      // floatingActionButton: _bookmarkButton(),
    );
  }

  void _goToHome() {
    Navigator.of(context).pushReplacementNamed('/');
  }
}
