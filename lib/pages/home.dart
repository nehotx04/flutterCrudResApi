import 'package:first_flutter_crud/pages/ProductEdit.dart';
import 'package:first_flutter_crud/pages/ProductForm.dart';
import 'package:first_flutter_crud/pages/ProductList.dart';
import 'package:first_flutter_crud/pages/UserEdit.dart';
import 'package:first_flutter_crud/pages/UserForm.dart';
import 'package:first_flutter_crud/pages/Testing.dart';
import 'package:first_flutter_crud/pages/UserList.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
          "Flutter",
          style:TextStyle(
            color:Colors.blue,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          ),

        Text(
          "Spring Boot",
          style:TextStyle(
            color:Colors.red,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            ),
          ),

      ],)),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

        ElevatedButton(
        child:Text("Crear usuarios",style:TextStyle(fontSize:16.0)),
        onPressed:()=>{ Navigator.push(context,MaterialPageRoute(builder: (context)=>User()))}),
        
        ElevatedButton(
        child:Text("Editar usuarios",style:TextStyle(fontSize:16.0)),
        onPressed:()=>{ Navigator.push(context,MaterialPageRoute(builder: (context)=>UserEdit()))}),

        ElevatedButton(
        child:Text("Lista de usuarios",style:TextStyle(fontSize:16.0)),
        onPressed:()=>{ Navigator.push(context,MaterialPageRoute(builder: (context)=>UsersList()))}),
        SizedBox(height: 25.0,),

        ElevatedButton(
        child:Text("Crear productos",style:TextStyle(fontSize:16.0)),
        onPressed:()=>{ Navigator.push(context,MaterialPageRoute(builder: (context)=>Product()))}),

        ElevatedButton(
        child:Text("Editar productos",style:TextStyle(fontSize:16.0)),
        onPressed:()=>{ Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductEdit()))}),

        ElevatedButton(
        child:Text("Lista de productos",style:TextStyle(fontSize:16.0)),
        onPressed:()=>{ Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductsList()))}),
        ],),
      ),
    );
  }
}