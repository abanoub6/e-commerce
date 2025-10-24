import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatelessWidget {
  const ImagesSlider({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          images
              .map(
                (image) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder:
                        (context, error, stackTrace) => const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 60,
                          ),
                        ),
                  ),
                ),
              )
              .toList(),
      options: CarouselOptions(
        height: 280,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 0.9,
        autoPlay: true, //
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeFactor: 0.25,
        scrollPhysics: const BouncingScrollPhysics(),
        initialPage: 0,
      ),
    );
  }
}
