import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => UsersListState();
  
}

class UsersListState extends State<UsersList> {

  List<dynamic> users = []; // Lista para almacenar los usuarios obtenidos de la API

  @override
  void initState() {
    super.initState();
    // Llamada a la función para obtener los usuarios al iniciar la vista
    _fetchUsersFromApi();
  }

  Future<void> _fetchUsersFromApi() async {
    var url = Uri.parse('http://192.168.1.113:8080/api/users'); // URL de tu API para obtener usuarios

    var response = await http.get(url); // Realiza la petición GET a la API

    if (response.statusCode == 200) {
      // Si la petición es exitosa, actualiza el estado de la vista con los usuarios obtenidos
      setState(() {
        users = json.decode(response.body);
      });
    } else {
      // Si hay un error en la petición, puedes manejarlo aquí
      print('Error en la petición: ${response.statusCode}');
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['name']), // Suponiendo que el nombre del usuario está en la clave 'name'
            subtitle: Text(users[index]['email']), // Suponiendo que el email del usuario está en la clave 'email'
          );
        },
      ),
    );
  }
}