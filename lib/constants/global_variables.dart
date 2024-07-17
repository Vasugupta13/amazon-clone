import 'package:flutter/material.dart';

//String uri = 'http://192.168.1.8:3000';
String uri = 'https://amazon-clone-server-vvb5.onrender.com';
class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
  static const kPrimaryColor = Color(0xfffaf1e7);
  static const kPrimaryTextColor = Color(0xff553c26);
  static const kLightPrimaryTextColor = Color(0xffecc3a8);
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'assets/images/candle1.png',
    'assets/images/candle2.png',
    'assets/images/candle3.png',
    'assets/images/candle4.png',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Jar Candles',
      'image': 'assets/images/candle.png',
    },
    {
      'title': 'Mould Candles',
      'image': 'assets/images/mold_candle.png',
    },
    {
      'title': 'Small Candles',
      'image': 'assets/images/candles.png',
    },
    {
      'title': 'Large Jar Candles',
      'image': 'assets/images/wide_jar_candle.png',
    },
  ];
}
