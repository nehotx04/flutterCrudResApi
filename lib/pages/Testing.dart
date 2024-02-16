import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final _formKey = GlobalKey<FormState>();

  Future<void> enviarDatos(String campo1, String campo2, String campo3) async {
  var url = Uri.parse('http://192.168.1.113:8080/api/users');
  var datos = {'name': campo1, 'lastname': campo2,'email': campo3}; // Datos del formulario

  var respuesta = await http.post(
    url,
    body: json.encode(datos), // Convierte los datos a formato JSON
    headers: {'Content-Type': 'application/json'}, // Especifica el tipo de contenido como JSON
  );

  if (respuesta.statusCode == 200) {
    print('Petición exitosa: ${respuesta.body}');
    // Manejar la respuesta aquí
  } else {
    print('Error en la petición: ${respuesta.statusCode}');
    // Manejar el error aquí
  }
}

  TextEditingController _campo1Controller = TextEditingController();
  TextEditingController _campo2Controller = TextEditingController();
  TextEditingController _campo3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Formulario'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _campo1Controller,
              decoration: InputDecoration(labelText: 'Campo 1'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Campo 1 no puede estar vacío";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _campo2Controller,
              decoration: InputDecoration(labelText: 'Campo 2'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Campo 2 no puede estar vacío";
                }
                return null;
              },
            ),
            
            TextFormField(
              controller: _campo3Controller,
              decoration: InputDecoration(labelText: 'Campo 3'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Campo 3 no puede estar vacío";
                }
                return null;
              },
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                  // Si el formulario es válido, enviar los datos
                  enviarDatos(_campo1Controller.text, _campo2Controller.text,_campo3Controller.text);
                }
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}