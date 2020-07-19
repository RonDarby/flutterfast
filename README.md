# PayFast Flutter App

FlutterFast

## ??Used??

### Services
- PayFast for the payments
- Firestore for the database
- Firebase functions for the ITN from PayFast
- Firebase hosting for the flutter and PayFast bridge

### Languages and Packages
- Flutter/Dart
    - flutter_bloc
    - url_launcher
    - webview_flutter
    - http
    - flutter_launcher_icons
    - flutter_launcher_name
    - path
    - firebase_core
    - firebase_auth
    - firebase_database
    - firebase_messaging
    - google_sign_in
    - cloud_firestore
    - uuid: ^2.2.0
- Javascript/Nodejs
    - firebase-functions
    - firebase-admin
    - express
    - cors
    - needle
    - dns
- HTML/Javascript
    - javascript
    - jQuery

## Resources

Some useful resources used for this app:

- [PayFast Developer Documentation](https://developers.payfast.co.za/documentation/)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Firbase Docs: Must Go Through Examples](https://firebase.google.com/docs)
- [IntelliJ IDEA](https://www.jetbrains.com/idea/)
- [Flutter for IntelliJ](https://github.com/flutter/flutter-intellij)

## Setup
### App
- Clone the respository
- Open the project in your IDEA
- Run `flutter pub get` in the project root
- Open the functions/functions folder and `npm install`
- Setup the Firebase, enable Authentication with Google, enable hosting, enable functions, enable firestore database
- Follow the Firebase base instructions to get firebase cli commands running from the /functions folder
- I've written 2 bash scripts to assist with flutter building and deploying of the web app, as well as deploying the functions to Firebase functions, both need to be exectuble to run
    - ./deploy_web.sh
    - ./deploy_functions.sh
- Once all setup (and hoping I havent missed a beat) you should be ready to run the app on an emulator of your choice.

# Small Print
## This is a work in progress, and for demostration purposes only!!!
## !!! NOT FOR DROP IN PRODUCTION USE !!!

Anyone looking to extend or improve on the app, is free to submit a pull request.
