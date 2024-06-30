import 'package:flutter/material.dart';
import 'package:tarea6/main.dart'; 

class ContratamePage extends StatelessWidget {
  const ContratamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Contrátame',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('lib/assets/perfilM2.jpg'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Información de contacto:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8.0),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('mgrullonreinoso@gmai.com'),
              onTap: () {
                // Open Gmail or any other email app
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('github.com/drzeroxs'),
              onTap: () {
                // Open GitHub profile
              },
            ),
          ],
        ),
      ),
    );
  }
}
