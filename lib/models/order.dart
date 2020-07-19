import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payfast/initiators.dart';
import 'package:payfast/models/product.dart';

class Order {
  final String id;
  final int total;
  final List<Product> items;
  final String userId;

  Order({
    this.id,
    this.userId,
    this.total,
    this.items,
  });

  factory Order.fromDocument(DocumentSnapshot doc) {

    return Order(
      id: doc.documentID,
      userId: doc['userId'],
      total: doc['total'],
      items: doc['items'].map((item) => Product.fromJson(item)).toList()
    );
  }
}