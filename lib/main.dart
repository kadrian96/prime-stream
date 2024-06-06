import 'package:flutter/material.dart';
import 'package:prime_stream/screens/loginScreen.dart';
import 'package:prime_stream/screens/registerScreen.dart';

void main() {
  runApp(const PrimeStream());
}

class PrimeStream extends StatelessWidget {
  const PrimeStream({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context){
  return Container(
     width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
              'PrimeStream',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Bienvenido a PrimeStream',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 50.0),
        LoginButton(context),
         SizedBox(height: 20.0),
        RegisterButton(context),
        
      ],
    ),
  );

}

Widget LoginButton(context){
  return(
    Container(
       
      child:ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
    )
  );
}

Widget RegisterButton(context){
  return(
    Container(
      
      child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Registro',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )
    )
  );
}





