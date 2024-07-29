import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class BannerWidget extends StatelessWidget{
  const BannerWidget({super.key});

  Widget build(BuildContext context){

    List<String> bannerUrl = [
      'images/banner/banner_1.png',
      'images/banner/banner_2.png',
      'images/banner/banner_3.png',
      'images/banner/banner_4.png'
    ];

    return CarouselSlider.builder(
      itemCount: bannerUrl.length,
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
      ),
      itemBuilder: (context, itemIndex, realIndex) {
        return Stack(
          children: [
            Image.asset(
              '${bannerUrl[itemIndex]}',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 180.0,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 35.0,
                height: 28.0,
                color: Colors.black38,
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.only(left: 6.0, top: 4.0),
                child: Text(
                  (itemIndex + 1).toString() +
                      '/' +
                      bannerUrl.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}