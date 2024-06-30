import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tarea6/main.dart';

class UniversidadesPage extends StatefulWidget {
  const UniversidadesPage({super.key});

  @override
  _UniversidadesPageState createState() => _UniversidadesPageState();
}

class _UniversidadesPageState extends State<UniversidadesPage> {
  List<dynamic> universities = [];
  bool isLoading = false;
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Buscar Universidades por País',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: countryController,
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre del país (en inglés)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String countryName = countryController.text.trim();
                if (countryName.isNotEmpty) {
                  fetchUniversities(countryName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor ingrese un nombre de país válido')),
                  );
                }
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: universities.length,
                      itemBuilder: (context, index) {
                        final university = universities[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  university['name'] ?? '',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text('Dominio: ${university['domains'].isEmpty ? "N/A" : university['domains'][0]}'),
                                SizedBox(height: 5),
                                Text('Página web: ${university['web_pages'].isEmpty ? "N/A" : university['web_pages'][0]}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUniversities(String countryName) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://universities.hipolabs.com/search?country=$countryName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          universities = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          universities = [];
          isLoading = false;
        });
        print('Failed to load universities: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        universities = [];
        isLoading = false;
      });
      print('Error fetching universities: $e');
    }
  }

  @override
  void dispose() {
    countryController.dispose();
    super.dispose();
  }
}
