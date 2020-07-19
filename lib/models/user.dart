import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String profileName;
  final String imageUrl;
  final String email;
  final String bio;

  User({
    this.id,
    this.profileName,
    this.imageUrl,
    this.email,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      email: doc['email'],
      imageUrl: doc['url'],
      profileName: doc['profileName'],
      bio: doc['bio'],
    );
  }
}