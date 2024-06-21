import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prime_stream/main.dart';

void main() {
  runApp(const Account());
}

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Map<dynamic, dynamic> currentuser = {
 
};

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  var email;
  void getData() {
    var tempemail;
    if (FirebaseAuth.instance.currentUser != null) {
      tempemail = FirebaseAuth.instance.currentUser?.email;
      email = tempemail.toString().replaceAll('.', 'punt0');
      print(email);
    }

    DatabaseReference productoRef =
        FirebaseDatabase.instance.ref('usuarios/$email');
    productoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print('Datos recibidos de Firebase: $data');
      updateUserList(data);
    });
  }

  void updateUserList(dynamic data) {
    if (data != null) {
      Map<dynamic, dynamic> tempuser = {};

      tempuser = {
        "email": data['email'],
        "lastname": data['lastname'],
        "name": data['name']
      };

      setState(() {
        currentuser = tempuser;
      });
      // print('Lista de productos actualizada: $productList');
    } else {
      print('No se recibieron datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Cuerpo(context));
  }
}

Widget Cuerpo(context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: (Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg"),
          ),
          SizedBox(height: 20),
          Text(
            'Nombre: ${currentuser['name']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
         Text(
            'Apellido: ${currentuser['lastname']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Correo: ${currentuser['email']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          BotonCerrarSesion(context)
        ],
      )),
    ),
  );
}

Widget BotonCerrarSesion(context) {
  return (FilledButton(
    onPressed: () {
      cerrarSesion();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PrimeStream()),
      );
    },
    child: Text("Cerrar Sesion"),
    style:
        ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red[600])),
  ));
}

Future<void> cerrarSesion() async {
  await FirebaseAuth.instance.signOut();
}
