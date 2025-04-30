import 'package:flutter/material.dart';
//import 'package:proyecto_movil/main.dart';


//void main() => runApp(const MyApp());

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height:250.0 ,
                width: 250.0,
                child: Image.asset('assets/pcm.jpg'),
                  
                  
              ),
               SizedBox(
                height:250.0 ,
                width: 250.0,
                child: Image.asset('assets/express2.jpg'),
                  
                  
              ),
SizedBox(height: 30),
    //CREANDO EL BOTON DE INGRESAR
    MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Color.fromRGBO(9, 18, 192, 1),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text('Continuar',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18
        ),),
      ),
      onPressed: (){
        Navigator.pushNamed(context, 'login');
      },
    )

            ],//children

          )
        ),
      ),
    );
  }
}