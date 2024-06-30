import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import '../api/enviroment.dart';

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  _ClimaPageState createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  String _weatherDescription = '';
  double _temperature = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final apiKey = Environment.openWeatherApiKey; // Coloca tu Api key aqui
    const city = 'Santo Domingo';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=es');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _weatherDescription = data['weather'][0]['description'];
        _temperature = data['main']['temp'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _weatherDescription = 'No se pudo obtener el clima';
        _temperature = 0.0;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Clima en RD',
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Clima en Santo Domingo',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _weatherDescription,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Temperatura: $_temperature°C',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
