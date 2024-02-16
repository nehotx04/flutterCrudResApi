import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  Future<void> _createProduct(String name, String lastname, String userId) async {
  var url = Uri.parse('http://192.168.1.113:8080/api/products');
  var datos = {'name': name, 'description': lastname,'userId': userId}; // Datos del formulario

  var respuesta = await http.post(
    url,
    body: json.encode(datos), // Convierte los datos a formato JSON
    headers: {'Content-Type': 'application/json'}, // Especifica el tipo de contenido como JSON
  );

  if (respuesta.statusCode == 200) {
    print('Petición exitosa: ${respuesta.body}');
  } else {
    print('Error en la petición: ${respuesta.statusCode}');
    // Manejar el error aquí
  }
}

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _descriptionFieldController = TextEditingController();
  TextEditingController _userIdFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Product",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Form",
            style: TextStyle(
              color: Colors.red,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _nameFieldController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "must complete this field";
                  }
                  return null;
                },
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Description",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _descriptionFieldController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "must complete this field";
                  }
                  return null;
                },
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "UserId",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _userIdFieldController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "must complete this field";
                  }
                  return null;
                },
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
                child: ElevatedButton(
              child: Text("Create Product",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal)),
              onPressed: () => {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate())
                  {
                    _createProduct(
                        _nameFieldController.text,
                        _descriptionFieldController.text,
                        _userIdFieldController.text),
                    
                    _nameFieldController.clear(),
                    _descriptionFieldController.clear(),
                    _userIdFieldController.clear(),
                    

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog( 
                          title: Text('Producto creado!'),
                          content: Text('El producto ha sido creado exitosamente'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cerrar'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    )
                  }
              },
            ))
          ],
        ),
      ),
    );
  }
}
