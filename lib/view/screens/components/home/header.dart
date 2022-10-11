import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
   HomeHeader({Key? key}) : super(key: key);

  List<String> listImage =  [
    "assets/image/header.png",
    "assets/image/header1.png",
    "assets/image/header.png",
    "assets/image/header1.png",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: true,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: listImage.map((e) => Image.asset(e,fit: BoxFit.cover,)).toList(),
    );
  }
}
