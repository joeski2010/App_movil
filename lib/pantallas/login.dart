
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //este metodo me devuleve el tamaño de la pantalla
    final size= MediaQuery.of(context).size;
    return  Scaffold(
      //CAJA PURPURA
body: Container(
  width: double.infinity,
  height: double.infinity,
//STACK sirve para contener un conjunto de widgets y apilarlos uno encima del otro
  child: Stack(
children: [
Container(
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(25),
  gradient: LinearGradient(colors:[
    Color.fromRGBO(9, 18, 192, 1),
    Color.fromRGBO(9, 18, 192, 1),
    

  ],),
  
),
//color: Colors.purple,
width: double.infinity,
height: size.height * 0.2,

//CIRCULOS PEQUEÑOS
child: Stack(
children: [
  Positioned(child: Container(
    width: 100,
    height:100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Color.fromRGBO(255,255,255, 0.05),
    ),

  ),
  top: 90,
  left: 30,
  ),
  

],

),
),
//WIDGET DE IMAGEN
Container(
  margin: EdgeInsets.only(top: 80),
width: double.infinity,
child: Text(
  'Hola! ',
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold
  ),
),

// child: Icon(
//   Icons.person_pin,
//   color: Colors.white,
//   size: 100,

// ),
),
//CAJA BLANCA DEL LOGIN
Column(
children: [  
SizedBox(height: 250),
Container(
padding:EdgeInsets.all(20),
margin: EdgeInsets.symmetric(horizontal: 30),
width: double.infinity,
//TAMAÑO DE LA CAJA
height: 450,  
//color:Colors.green,
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(25),
boxShadow: [
  BoxShadow(
    color: Colors.black12,
    offset: Offset(0, 5),
    blurRadius: 50,
    //spreadRadius: -5
  )
]

),
child: Column(
children: [
  SizedBox(height: 10),
  Text(
    'Ingresar datos PRUEBA',
     style:Theme.of(context).textTheme.headlineMedium,),
  //Espacio entre el texto y el siguiente widget
  SizedBox(height: 20),
  Container(
    child: Form(
child: Column(
  children: [
    TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        hintText: 'Tipo de Documento',
        labelText: 'Tipo de Documento',
        prefixIcon: Icon(Icons.person),
        //suffixIcon: Icon(Icons.check_circle),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      ),
    ),
    SizedBox(height: 20),
      TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        hintText: 'Nro de Documento',
        labelText: 'Nro de Documento',
        prefixIcon: Icon(Icons.search),
        //suffixIcon: Icon(Icons.check_circle),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      ),
    ),
    SizedBox(height: 20),
    TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        hintText: 'Fecha de Emisión',
        //labelText: 'Fecha de Emisión',
        prefixIcon: Icon(Icons.date_range),
        //suffixIcon: Icon(Icons.check_circle),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      ),
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
        child: Text('Ingresar',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18
        ),),
      ),
      onPressed: (){
        Navigator.pushNamed(context, 'home');
      },
    )
  ],
)

    )
  )
],

)


),
SizedBox(height: 30),
// Text('Crear una cuenta Nueva',
// style: TextStyle(
//   //color: Colors.white,
//   fontSize: 15,
//   fontWeight: FontWeight.bold
// ),),

],


)

],

  ),

)


    );
  }
}