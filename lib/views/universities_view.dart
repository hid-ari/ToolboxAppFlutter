import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UniversitiesView extends StatefulWidget {
  const UniversitiesView({super.key});

  @override
  State<UniversitiesView> createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  String country = "";
  List universities = [];

  Future<void> fetchUniversities() async {
    final response = await http.get(
      Uri.parse("https://adamix.net/proxy.php?country=$country"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      universities = data;
    });
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Universidades por País")),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => country = value,
            decoration:
                const InputDecoration(labelText: "Nombre del país en inglés"),
          ),
          ElevatedButton(
              onPressed: fetchUniversities,
              child: const Text("Buscar")),
          Expanded(
            child: ListView.builder(
              itemCount: universities.length,
              itemBuilder: (context, index) {
                final uni = universities[index];
                return Card(
                  child: ListTile(
                    title: Text(uni["name"]),
                    subtitle: Text(
                        "Dominio: ${uni["domains"][0]}\nWeb: ${uni["web_pages"][0]}"),
                    onTap: () => openUrl(uni["web_pages"][0]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}