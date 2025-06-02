import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proyecto_movil/screens/login_screen.dart';
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', 'US'), const Locale('es', 'ES')],
      title: 'MAC Express',
      routes: {
        'page': (_) => PageScreen(),
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),

        // 'home': (context) => const Home(),
      },
      initialRoute: 'page',
    );
  }
}
