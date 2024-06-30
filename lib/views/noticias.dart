import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher
import '../main.dart';

class NoticiasPage extends StatefulWidget {
  const NoticiasPage({Key? key}) : super(key: key);

  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  String siteLogoUrl = 'https://quieremecomosoy.com/wp-content/uploads/2022/04/cropped-cropped-LOGO-2-2-2.png'; // URL del logo de "https://quieremecomosoy.com/"
  List<dynamic> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final url = Uri.parse('https://quieremecomosoy.com/wp-json/wp/v2/posts?per_page=3'); // Ejemplo de URL de la API de "https://quieremecomosoy.com/"

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = data;
          isLoading = false;
        });
      } else {
        setState(() {
          articles = [];
          isLoading = false;
        });
        print('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        articles = [];
        isLoading = false;
      });
      print('Error fetching articles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Quiereme como soy',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    siteLogoUrl,
                    height: 100,
                    width: 300,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article['title']['rendered'] ?? '',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  article['excerpt']['rendered'] ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Abrir la noticia completa en el navegador
                                    _launchURL(article['link']);
                                  },
                                  child: Text('Visitar Noticia'),
                                ),
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

  // Método para abrir una URL en el navegador
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
}
