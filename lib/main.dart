import 'package:flutter/material.dart';
import 'package:proyecto_movil/pantallas/login.dart';
import 'package:proyecto_movil/pantallas/home.dart';
import 'package:proyecto_movil/pantallas/page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //PARA ELIMINAR EL BANNER DE DEBUGGIN
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes : {
        'page': (_) => PageScreen(),
        'login': (_) =>LoginScreen(),
        'home': (_) => HomeScreen(),
        
        // 'home': (context) => const Home(),
      }, 
      initialRoute: 'page' ,
    );
  }
}
