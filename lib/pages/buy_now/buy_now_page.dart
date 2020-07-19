import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:payfast/initiators.dart';
import 'package:payfast/models/product.dart';
import 'package:payfast/pages/payfast/payfast_page.dart';
import 'package:payfast/services/auth/auth_bloc.dart';
import 'package:payfast/utils/config.dart';
import 'package:payfast/utils/screen_arguments.dart';
import 'package:uuid/uuid.dart';

class BuyNowPage extends StatefulWidget {
  BuyNowPage({Key key}) : super(key: key);

  @override
  _BuyNowPageState createState() => _BuyNowPageState();
}

class _BuyNowPageState extends State<BuyNowPage> {
  AuthBloc _authBloc;
  List<Product> products = [];
  List<Map<String,dynamic>> order;
  num sum = 0;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _getProducts();
    order = [];
  }

  void _blocListener(context, state) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Buy Now'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _goToHome,
          ),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: _blocListener,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (_, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo.png'),
                          width: 70.0,
                          height: 70.0,
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            Product product = products[index];

                            return Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 30),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(product.itemName),
                                        Text(product.itemDescription),
                                        Text('R ' +
                                            (product.price / 100).toString())
                                      ],
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed:  () => _addToCart(product),
                                        icon: Icon(Icons.add_shopping_cart),
                                      ),
                                    )
                                  ],
                                ));
                          }),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child:
                                  Text('Total: R ' + sum.toString()),
                            ),
                            Expanded(
                                flex: 1,
                                child: sum == 0 ? Container() : FlatButton.icon(
                                    onPressed: _goToPayFast,
                                    icon: Icon(Icons.payment),
                                    label: Text('Go Pay')))
                          ],
                        )),
                  ],
                ),
              );
            },
          ),
        ));
  }

  void _goToHome() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _goToPayFast() async {
    String orderId = UniqueKey().toString();
    ordersReference
        .document(orderId)
        .setData({
      "userId": _authBloc.user.id,
      "total": sum,
      "items": order
        });
    Map<String, String> body = {
      "merchant_id": Configs.merchant_id,
      "merchant_key": Configs.merchant_key,
      "notify_url": Configs.notify_url,
      "name_first": _authBloc.user.profileName,
      "email_address": _authBloc.user.email,
      "m_payment_id": orderId,
      "amount": sum.toString(),
      "item_name": 'FlutterFast Cart'
    };

    var client = http.Client();
    Map<String, String> headers = {"Content-type": "application/json"};

    var response;
    try {
      response = await client.post(
          'https://test.secureserv.co.za/onsite/signature/test',
          body: jsonEncode(body),
          headers: headers);
      body['signature'] = jsonDecode(response.body)['signature'];

      response = await client.post(
          'https://test.secureserv.co.za/onsite/process',
          body: jsonEncode(body),
          headers: headers);
    } finally {
      client.close();
    }

    Navigator.pushNamed(context, PayFastExplorer.route,
        arguments: ScreenArguments(body: response.body));
  }

  void _getProducts() async {
    QuerySnapshot productSnap =
        await productsReference.orderBy('price').getDocuments();

    setState(() {
      products = productSnap.documents
          .map((document) => Product.fromDocument(document))
          .toList();
    });
  }

  _addToCart(Product product) {
    order.add(product.toJson());
    setState(() {
      sum += (product.price/100);
    });
  }

}
