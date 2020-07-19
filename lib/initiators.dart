import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


final GoogleSignIn gSignIn = GoogleSignIn();
FirebaseMessaging firebaseMessaging = FirebaseMessaging();
final scaffoldKey = GlobalKey<ScaffoldState>();
final usersReference = Firestore.instance.collection("users");
final productsReference = Firestore.instance.collection("items");
final ordersReference = Firestore.instance.collection("orders");
