import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payfast/main.dart';

class Product {
  final String id;
  final int price;
  final String itemName;
  final String itemDescription;

  Product({
    this.id,
    this.itemName,
    this.itemDescription,
    this.price
  });

  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'],
      price: json['price'],
      itemName: json['itemName'],
      itemDescription: json['itemDescription']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id": this.id,
      "price": this.price,
      "itemName": this.itemName,
      "itemDescription": this.itemDescription
    };
  }

  factory Product.fromDocument(DocumentSnapshot doc) {

    return Product(
      id: doc.documentID,
      price: doc['price'],
      itemDescription: doc['itemDescription'],
      itemName: doc['itemName']
    );
  }
}