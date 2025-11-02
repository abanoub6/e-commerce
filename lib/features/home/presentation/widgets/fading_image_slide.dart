import 'dart:async';
import 'package:flutter/material.dart';

class FadingImageSlider extends StatefulWidget {
  const FadingImageSlider({super.key});

  @override
  FadingImageSliderState createState() => FadingImageSliderState();
}

class FadingImageSliderState extends State<FadingImageSlider> {
  final List<String> images = [
    'assets/images/im1.png',
    'assets/images/im2.png',
    'assets/images/im3.png',
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // يغير الصورة كل 3 ثواني
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: AnimatedSwitcher(
        duration: Duration(seconds: 1), // سرعة التلاشي
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child: Image.asset(
          images[_currentIndex],
          key: ValueKey<String>(images[_currentIndex]),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
