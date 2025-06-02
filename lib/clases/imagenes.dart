import 'package:flutter/material.dart';

class BotonesConImagen {
  static Widget buildBotonesFila(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
              child: Image.asset(
                'assets/favoritos.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'ruta2');
              },
              child: Image.asset('assets/bn.png', width: 100, height: 100),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'ruta3');
              },
              child: Image.asset('assets/osce.png', width: 100, height: 100),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'ruta3');
              },
              child: Image.asset('assets/inpe3.png', width: 100, height: 100),
            ),
          ],
        ),
      ),
    );
  }
}
