import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderView extends StatefulWidget {
  const GenderView({super.key});

  @override
  State<GenderView> createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  String name = "";
  String? gender;

  Future<void> predictGender() async {
    final response = await http.get(
      Uri.parse("https://api.genderize.io/?name=$name"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      gender = data["gender"];
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    if (gender == "male") bgColor = Colors.blue.shade200;
    if (gender == "female") bgColor = Colors.pink.shade200;

    return Scaffold(
      appBar: AppBar(title: const Text("Predicción de Género")),
      backgroundColor: bgColor,
      body: Column(
        children: [
          TextField(
            onChanged: (value) => name = value,
            decoration: const InputDecoration(labelText: "Nombre"),
          ),
          ElevatedButton(
            onPressed: predictGender,
            child: const Text("Predecir"),
          ),
          if (gender != null) Text("Género: $gender")
        ],
      ),
    );
  }
}