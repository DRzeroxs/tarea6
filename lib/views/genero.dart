import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tarea6/main.dart'; 

class GeneroPage extends StatefulWidget {
  const GeneroPage({super.key});

  @override
  _GeneroPageState createState() => _GeneroPageState();
}

class _GeneroPageState extends State<GeneroPage> {
  final TextEditingController _controller = TextEditingController();
  String _gender = '';
  bool _isLoading = false;

  Future<void> _predictGender(String name) async {
    final url = Uri.parse('https://api.genderize.io/?name=$name');
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _gender = 'error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Predicción de Género',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese un nombre',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _predictGender(_controller.text);
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _gender.isNotEmpty
                    ? _gender == 'male'
                        ? Icon(
                            Icons.male,
                            color: Colors.blue,
                            size: 100,
                          )
                        : Icon(
                            Icons.female,
                            color: Colors.pink,
                            size: 100,
                          )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
