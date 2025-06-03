import 'package:flutter/material.dart';
import 'dart:async';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              _buildBrandLogo('assets/pcm.jpg'),
              const SizedBox(height: 80),
              _buildBrandLogo('assets/mac_express_logo.png'),
              const SizedBox(height: 80),
              const CarouselTextSlider(),
              const SizedBox(height: 80),
              _buildContinueButton(context),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandLogo(String assetPath) {
    return SizedBox(
      width: 250,
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D24AA),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        onPressed: () {
          Navigator.pushNamed(context, 'login');
        },
        child: const Text(
          'Continuar',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CarouselTextSlider extends StatefulWidget {
  const CarouselTextSlider({super.key});

  @override
  State<CarouselTextSlider> createState() => _CarouselTextSliderState();
}

class _CarouselTextSliderState extends State<CarouselTextSlider> {
  final List<String> _textSlides = [
    "Encuentra los servicios del estado al alcance de tus manos",
    "Accede a la galería de servicios de manera ágil",
    "También puedes localizar los servicios presenciales más cercanos con sus horarios de atención"
  ];
  
  late final PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;
  final double _carouselHeight = 90;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < _textSlides.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _carouselHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _textSlides.length,
            itemBuilder: (_, index) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _currentIndex == index ? 1.0 : 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    _textSlides[index],
                    style: TextStyle(
                      fontSize: 16,
                      color: _currentIndex == index 
                          ? Colors.black 
                          : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        // Barras del slider con ancho flexible
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_textSlides.length, (index) {
            return Container(
              constraints: BoxConstraints(maxWidth: 30),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: _currentIndex == index 
                      ? const Color.fromARGB(255, 193, 39, 45)
                      : const Color.fromARGB(255, 162, 179, 179),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}