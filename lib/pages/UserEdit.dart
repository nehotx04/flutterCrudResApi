import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserEdit extends StatefulWidget {
  const UserEdit({super.key});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  Future<void> _editUser(
      String name, String lastname, String email, String id) async {
    var url = Uri.parse('http://192.168.1.113:8080/api/users/edit/' + id);
    print(url);
    var datos = {
      'name': name,
      'lastname': lastname,
      'email': email
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
  TextEditingController _lastnameFieldController = TextEditingController();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _idFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "EditUser",
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
              "Lastname",
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
                controller: _lastnameFieldController,
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
              "Email",
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
                controller: _emailFieldController,
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
              child: Text("Edit User",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal)),
              onPressed: () => {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate())
                  {
                    _editUser(
                        _nameFieldController.text,
                        _lastnameFieldController.text,
                        _emailFieldController.text,
                        _idFieldController.text),
                    _nameFieldController.clear(),
                    _lastnameFieldController.clear(),
                    _emailFieldController.clear(),
                    _idFieldController.clear(),

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Usuario Editado!'),
                          content:
                              Text('El usuario ha sido editado exitosamente'),
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
