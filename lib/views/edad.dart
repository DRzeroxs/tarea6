import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tarea6/main.dart'; 

class EdadPage extends StatefulWidget {
  const EdadPage({super.key});

  @override
  _EdadPageState createState() => _EdadPageState();
}

class _EdadPageState extends State<EdadPage> {
  final TextEditingController _controller = TextEditingController();
  int? _age;
  bool _isLoading = false;
  String _ageGroup = '';

  Future<void> _predictAge(String name) async {
    final url = Uri.parse('https://api.agify.io/?name=$name');
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'];
        _ageGroup = _determineAgeGroup(_age);
        _isLoading = false;
      });
    } else {
      setState(() {
        _age = null;
        _ageGroup = '';
        _isLoading = false;
      });
    }
  }

  String _determineAgeGroup(int? age) {
    if (age == null) return '';
    if (age < 18) {
      return 'joven';
    } else if (age < 60) {
      return 'adulto';
    } else {
      return 'anciano';
    }
  }

  IconData _getAgeGroupIcon(String ageGroup) {
    switch (ageGroup) {
      case 'joven':
        return Icons.child_care;
      case 'adulto':
        return Icons.person;
      case 'anciano':
        return Icons.elderly;
      default:
        return Icons.help;
    }
  }

  Color _getAgeGroupColor(String ageGroup) {
    switch (ageGroup) {
      case 'joven':
        return Colors.green;
      case 'adulto':
        return Colors.blue;
      case 'anciano':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Predicción de Edad',
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
                _predictAge(_controller.text);
              },
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _age != null
                    ? Column(
                        children: [
                          Text(
                            'Edad: $_age',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Esta persona es $_ageGroup',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 20),
                          Icon(
                            _getAgeGroupIcon(_ageGroup),
                            color: _getAgeGroupColor(_ageGroup),
                            size: 100,
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
