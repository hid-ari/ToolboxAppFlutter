import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgeView extends StatefulWidget {
  const AgeView({super.key});

  @override
  State<AgeView> createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  String name = "";
  int? age;
  String category = "";
  String image = "";

  Future<void> predictAge() async {
    final response =
        await http.get(Uri.parse("https://api.agify.io/?name=$name"));
    final data = jsonDecode(response.body);

    age = data["age"];

    if (age != null) {
      if (age! < 18) {
        category = "Joven";
        image = "assets/joven.png";
      } else if (age! < 60) {
        category = "Adulto";
        image = "assets/adulto.png";
      } else {
        category = "Anciano";
        image = "assets/anciano.png";
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Predicción de Edad")),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => name = value,
            decoration: const InputDecoration(labelText: "Nombre"),
          ),
          ElevatedButton(
              onPressed: predictAge, child: const Text("Predecir")),
          if (age != null) ...[
            Text("Edad: $age"),
            Text(category),
            Image.asset(image)
          ]
        ],
      ),
    );
  }
}