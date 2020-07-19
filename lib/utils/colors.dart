import 'package:flutter/material.dart';

const MaterialColor pfpallete = MaterialColor(_pfpalletePrimaryValue, <int, Color>{
  50: Color(0xFFFBE9E6),
  100: Color(0xFFF6C7C0),
  200: Color(0xFFF0A297),
  300: Color(0xFFEA7C6D),
  400: Color(0xFFE6604D),
  500: Color(_pfpalletePrimaryValue),
  600: Color(0xFFDD3E29),
  700: Color(0xFFD93523),
  800: Color(0xFFD52D1D),
  900: Color(0xFFCD1F12),
});
const int _pfpalletePrimaryValue = 0xFFE1442E;

const MaterialColor pfpalleteAccent = MaterialColor(_pfpalleteAccentValue, <int, Color>{
  100: Color(0xFFFFFCFC),
  200: Color(_pfpalleteAccentValue),
  400: Color(0xFFFF9B96),
  700: Color(0xFFFF837C),
});
const int _pfpalleteAccentValue = 0xFFFFCBC9;