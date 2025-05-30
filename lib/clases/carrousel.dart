import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  final List<String> imageUrls = const [
     'assets/reniec.png',
     'assets/banco.png',
     'assets/inpe.png',
    
  
    
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
        ),
        items: imageUrls.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}