import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tarea6/main.dart'; 

class PortadaPage extends StatelessWidget {
  const PortadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Portada',
      body: Center(
        child: FaIcon(
          FontAwesomeIcons.toolbox,
          size: 100.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
