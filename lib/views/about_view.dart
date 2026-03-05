import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acerca de")),
      body: Column(
        children: const [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage("assets/mi_foto.jpg"),
          ),
          SizedBox(height: 20),
          Text("Nombre: Hideki Rafael Sarmiento Ariyama"),
          Text("Matrícula: 2024-1453"),
          Text("Email: Ariyamahideki1@gmail.com"),
          Text("Teléfono: 829-410-1140"),
          Text("GitHub: https://github.com/hid-ari"),
        ],
      ),
    );
  }
}