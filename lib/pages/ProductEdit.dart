import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductEdit extends StatefulWidget {
  const ProductEdit({super.key});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  Future<void> _editProduct(
      String name, String description,String userId, String id) async {
    var url = Uri.parse('http://192.168.1.113:8080/api/products/edit/' + id);
    print(url);
    var datos = {
      'name': name,
      'description': description,
      'userId': int.parse(userId),
    }; // Datos del formulario

    var respuesta = await http.put(
      url,
      body: json.encode(datos), // Convierte los datos a formato JSON
      headers: {
        'Content-Type': 'application/json'
      }, // Especifica el tipo de contenido como JSON
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
  TextEditingController _idFieldController = TextEditingController();
  TextEditingController _userIdFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "EditProduct",
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
      body: ListView(
        children: [
          Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Id",
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
                controller: _idFieldController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "must complete this field";
                  }
                  return null;
                },
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),

            Text(
              "User Id",
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
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "must complete this field";
                  }
                  return null;
                },
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),

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
            
            SizedBox(height: 30.0),
            Center(
                child: ElevatedButton(
              child: Text("Edit Product",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal)),
              onPressed: () => {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate())
                  {
                    _editProduct(
                        _nameFieldController.text,
                        _descriptionFieldController.text,
                        _userIdFieldController.text,
                        _idFieldController.text),
                    _nameFieldController.clear(),
                    _descriptionFieldController.clear(),
                    _idFieldController.clear(),
                    _userIdFieldController.clear(),

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Producto Editado!'),
                          content:
                              Text('El producto ha sido editado exitosamente'),
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
        ), )
        ],
      ),
    );
  }
}
