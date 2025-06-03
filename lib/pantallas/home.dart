import 'package:flutter/material.dart';
//import 'package:proyecto_movil/clases/autocompletar.dart';
import 'package:proyecto_movil/clases/carrousel.dart';
//import 'package:proyecto_movil/clases/historial_busquedas.dart';
import 'package:proyecto_movil/clases/sugerencias.dart';
import 'package:proyecto_movil/clases/imagenes.dart';
import 'package:proyecto_movil/pantallas/login.dart';
//import 'package:proyecto_movil/clases/contorno.dart';
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
      //initialRoute: '/',
      routes: {
        //'/': (context) => HomeScreen(),
        'login': (context) => LoginScreen(),
        'login2': (context) => LoginScreen(),
        'login3': (context) => LoginScreen(),
        'login4': (context) => LoginScreen(),
              },

      // routes: {
      //   'login': (context) => LoginScreen(),
      //   'login2': (context) => LoginScreen(),
      //   'login3': (context) => LoginScreen(),
      // },
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
                  borderRadius: BorderRadius.circular(23),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(9, 18, 192, 1),
                      Color.fromRGBO(9, 18, 192, 1),
                    ],
                  ),
                ),
                width: double.infinity,
                height: size.height * 0.11,
                child: Stack(
                  children: [
                    Positioned(
                      top: 90,
                      left: 30,
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: const Color.fromARGB(13, 77, 79, 96),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Column(
                children: <Widget>[
                  //SearchField(),
                  const SizedBox(height: 20),
                  Center(
                    //CAMBIAR EL ANCHO DE LA CAJA DE BUSQUEDA
                    child: SizedBox(width: 380, child: CustomAutocomplete()),
                  ),

                  //SearchWithHistory(),
                  const SizedBox(height: 40),

                  //const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Lo más buscado',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Aquí puedes agregar más widgets o contenido
                  const ImageCarousel(),
                  const SizedBox(height: 5),
                  BotonesConImagen.buildBotonesFila(context),
                ], //children
              ),



              //const SizedBox(height: 00),
              // Aquí puedes agregar más widgets o contenido
              
          
              Positioned(
                bottom: 200,
                left: 50,
                right: 50,
                child: MaterialButton(
                  minWidth: 200, //Ancho
                  height: 50, //Alto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: const Color.fromARGB(255, 9, 145, 207),
                  onPressed: () {
                    {
                      Navigator.pushNamed(context, 'login');
                    }
                  },
                  //                               child: Row(
                  //   mainAxisSize: MainAxisSize.min, // Para que el botón se ajuste al contenido
                  //   children: [
                  //     Icon(Icons.info),
                  //     SizedBox(width: 8), // Espacio entre ícono y texto
                  //     Text('Info'),
                  //   ],
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize:
                        MainAxisSize
                            .min, // Para que el botón se ajuste al contenido
                    children: [
                      Text(
                        'Ver todos los servicios',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(width: 15), // Espacio entre ícono y texto
                      Icon(Icons.list_alt_sharp, color: Colors.white),
                    ],
                  ),
                ),
              ),

              //           Positioned(
              //             bottom: 100,
              //             left: 100,
              //             right: 100,

              //             child: ElevatedButton( onPressed: () {
              //             // Acción al presionar el botón
              //             print('Botón presionado');
              //           },
              //           style: ElevatedButton.styleFrom(
              //   backgroundColor: const Color.fromARGB(255, 47, 6, 233), // Color de fondo del botón
              //   foregroundColor: Colors.white, // Color del texto o ícono
              // ),
              //           child: Text('Ver todos los servicios'),),
              //           ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 17, 16, 53),
          shape: CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          tooltip: 'Información',
          child: Icon(
            Icons.info_outline,
            color: const Color.fromARGB(255, 238, 237, 237),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

        // floatingActionButton: FloatingActionButton(
        //           onPressed: () {
        //             setState(() {
        //               isDark = !isDark;
        //             });
        //           },
        //           child: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        //         ),

        bottomNavigationBar: BottomNavigationBar(
           currentIndex: 0,
          onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, 'login');
          } else if (index == 2) {
            Navigator.pushNamed(context, 'logi2');
          }else if (index == 3) {
            Navigator.pushNamed(context, 'login3');
          }


          // Si es index 0 no hace nada porque ya está en home
        },



          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255,198,2,2,), // Fondo del navbar
          selectedItemColor: Colors.white, // Color del ítem seleccionado
          unselectedItemColor: Colors.white, // Ítems no seleccionados

          items: [
            BottomNavigationBarItem(label: "Inicio", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
              label: "Encuentranos",
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: "Contactanos",
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: "Satisfacción",
              icon: Icon(Icons.directions),
            ),
          ],
        ),
        // bottomNavigationBar: BottomAppBar(
        //   color: Colors.transparent,
        //   elevation: 0,
        //   child: Container(
        //     height: 10,
        //     width: double.infinity,

        //     decoration: BoxDecoration(
        //       // border: Border.all(
        //       //   color: const Color.fromARGB(255, 243, 243, 243),
        //       //   width: 2,
        //       // ),
        //       //borderRadius: BorderRadius.circular(12),
        //       gradient: LinearGradient(
        //         colors: [
        //           const Color.fromARGB(255, 245, 4, 4),
        //           const Color.fromARGB(255, 163, 35, 35),
        //         ],
        //       ),
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         IconButton(
        //           icon: Icon(Icons.home, color: Colors.white),
        //           onPressed: () {
        //             Navigator.pushNamed(context, 'login');
        //           },
        //           //iconSize: 50,
        //           //color: Colors.red,
        //         ),
        //         SizedBox(height: 10),
        //         Text("Home", style: TextStyle(fontSize: 12)),

        //         IconButton(
        //           icon: Icon(Icons.search, color: Colors.white),
        //           onPressed: () {
        //             Navigator.pushNamed(context, 'search');
        //           },
        //         ),
        //         Text("Home", style: TextStyle(fontSize: 12)),
        //         IconButton(
        //           icon: Icon(Icons.person, color: Colors.white),
        //           onPressed: () {
        //             Navigator.pushNamed(context, 'profile');
        //           },
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.directions, color: Colors.white),
        //           onPressed: () {
        //             Navigator.pushNamed(context, 'satisfaction');
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ), //BOTON
        // bottomNavigationBar: BottomAppBar(
        //   color: Color.fromARGB(255, 205, 10, 23),
        //   child: SafeArea(
        //     child: SizedBox(
        //       height: 70, // Ajusta este valor para que no haya overflow
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 5),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             Flexible(
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,

        //                 children: [
        //                   IconButton(
        //                     icon: Icon(Icons.home, color: Colors.white),
        //                     onPressed: () {
        //                       Navigator.pushNamed(context, 'login');
        //                     },
        //                     padding:
        //                         EdgeInsets
        //                             .zero, // reduce padding del icono para ajustarlo
        //                     constraints:
        //                         BoxConstraints(), // elimina restricciones predeterminadas
        //                   ),
        //                   Text(
        //                     "Inicio",
        //                     style: TextStyle(color: Colors.white, fontSize: 12),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Flexible(
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   IconButton(
        //                     icon: Icon(Icons.map, color: Colors.white),
        //                     onPressed: () {
        //                       Navigator.pushNamed(context, 'login');
        //                     },
        //                     padding: EdgeInsets.zero,
        //                     constraints: BoxConstraints(),
        //                   ),
        //                   Text(
        //                     "Encuentranos",
        //                     style: TextStyle(color: Colors.white, fontSize: 12),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Flexible(
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   IconButton(
        //                     icon: Icon(Icons.cloud, color: Colors.white),
        //                     onPressed: () {
        //                       Navigator.pushNamed(context, 'login');
        //                     },
        //                     padding: EdgeInsets.zero,
        //                     constraints: BoxConstraints(),
        //                   ),
        //                   Text(
        //                     "Contactanos",
        //                     style: TextStyle(color: Colors.white, fontSize: 12),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Flexible(
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   IconButton(
        //                     icon: Icon(Icons.person, color: Colors.white),
        //                     onPressed: () {
        //                       Navigator.pushNamed(context, 'login');
        //                     },
        //                     padding: EdgeInsets.zero,
        //                     constraints: BoxConstraints(),
        //                   ),
        //                   Text(
        //                     "Satisfacción",
        //                     style: TextStyle(color: Colors.white, fontSize: 12),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
} //class searchbar
