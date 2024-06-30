import 'package:flutter/material.dart';
import 'views/portada.dart';
import 'views/genero.dart';
import 'views/edad.dart';
import 'views/universidades.dart';
import 'views/clima.dart';
import 'views/noticias.dart';
import 'views/contratame.dart';
import 'api/enviroment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 166, 225, 252)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PortadaPage(),
        '/genero': (context) => const GeneroPage(),
        '/edad': (context) => const EdadPage(),
        '/universidades': (context) => const UniversidadesPage(),
        '/clima': (context) => const ClimaPage(),
        '/noticias': (context) => const NoticiasPage(),
        '/contratame': (context) => const ContratamePage(),
      },
    );
  }
}



class BasePage extends StatelessWidget {
  final String title;
  final Widget body;

  const BasePage({required this.title, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 137, 153, 84),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.man_outlined),
              title: const Text('Genero por nombre'),
              onTap: () {
                Navigator.pushNamed(context, '/genero');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_4),
              title: const Text('Edad por nombre'),
              onTap: () {
                Navigator.pushNamed(context, '/edad');
              },
            ),
            ListTile(
              leading: const Icon(Icons.holiday_village_sharp),
              title: const Text('Universidades por pais'),
              onTap: () {
                Navigator.pushNamed(context, '/universidades');
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text('Clima en RD'),
              onTap: () {
                Navigator.pushNamed(context, '/clima');
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                Navigator.pushNamed(context, '/noticias');
              },
              
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Contacto'),
              onTap: () {
                Navigator.pushNamed(context, '/contratame');
              },
              
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
