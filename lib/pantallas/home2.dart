import 'package:flutter/material.dart';
//import 'package:proyecto_movil/clases/autocompletar.dart';
import 'package:proyecto_movil/clases/carrousel.dart';
//import 'package:proyecto_movil/clases/historial_busquedas.dart';
import 'package:proyecto_movil/clases/sugerencias.dart';
//import 'package:proyecto_movil/clases/redireccionar.dart';



/// Flutter code sample for [SearchBar].

//void main() => runApp(const HomeScreen());

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<HomeScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
         
         
         
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        
       //appBar: AppBar(title: const Text('')),
        body: SafeArea(
          //padding: const EdgeInsets.all(8.0),

          child: Stack(
children: [
           Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(9, 18, 192, 1),
                    Color.fromRGBO(9, 18, 192, 1),
                  ],
                ),
              ),
              width: double.infinity,
              height: size.height * 0.2,
              child: Stack(
                children: [
                  Positioned(
                    top: 90,
                    left: 30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromRGBO(255, 255, 255, 0.05),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
      
              //SearchField(),

              CustomAutocomplete(),

              //SearchWithHistory(),


const SizedBox(height: 40),
                const Text(
                  '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Lo más buscado',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    
                    
                    fontSize: 16
                    
                    ),
                   
                ),
                const SizedBox(height: 20),
                // Aquí puedes agregar más widgets o contenido



              const ImageCarousel(),
              ],
            ),
          ],


          )






          
        ),






      

        bottomNavigationBar: BottomNavigationBar(
          
           
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(label: "Inicio", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Encuentranos",icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(label: "Contactanos",icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(label: "Satisfacción", icon: Icon(Icons.directions)),
          ],
        ),





        
      ),

      
    );
  }
}


