import 'package:flutter/material.dart';
import 'gender_view.dart';
import 'age_view.dart';
import 'universities_view.dart';
import 'weather_view.dart';
import 'pokemon_view.dart';
import 'wordpress_view.dart';
import 'about_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toolbox App")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/toolbox.jpg"),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const GenderView())),
              child: const Text("Predecir Género"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AgeView())),
              child: const Text("Predecir Edad"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const UniversitiesView())),
              child: const Text("Universidades por País"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const WeatherView())),
              child: const Text("Clima RD"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const PokemonView())),
              child: const Text("Buscar Pokémon"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const WordPressView())),
              child: const Text("Noticias WordPress"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AboutView())),
              child: const Text("Acerca de"),
            ),
          ],
        ),
      ),
    );
  }
}