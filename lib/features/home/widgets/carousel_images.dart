import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Swiper(
        itemCount: GlobalVariables.carouselImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(GlobalVariables.carouselImages[index],height: 300,);
        },
        scale: 0.9,
        autoplay: true,
      ),
    );
  }
}