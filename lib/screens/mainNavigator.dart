import 'package:flutter/material.dart';
import 'package:prime_stream/screens/CatalogoScreen.dart';
import 'package:prime_stream/screens/cuentaScreen.dart';

void main() {
  runApp(const MainNavigator());
}

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      title: 'PrimeStream',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
       debugShowCheckedModeBanner: false,
   );
}
}
int indice=0;
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
    Catalogo(),
    Account(),
  ];
     return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(indice),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cuenta',
          ),
        ],
        currentIndex: indice,
        selectedItemColor: Colors.deepPurple,
        onTap: (value) {
         setState(() {
           indice=value;
         });
        },
      ),
    );
  }
}
