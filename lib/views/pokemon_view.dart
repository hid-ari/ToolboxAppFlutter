import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({super.key});

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  String name = "";
  Map? pokemon;
  final AudioPlayer player = AudioPlayer();

  Future<void> fetchPokemon() async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$name"));
    final data = jsonDecode(response.body);
    setState(() {
      pokemon = data;
    });
  }

  Future<void> playSound(String url) async {
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar Pokémon")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (value) => name = value.toLowerCase(),
              decoration: const InputDecoration(labelText: "Nombre del Pokémon"),
            ),
            ElevatedButton(
                onPressed: fetchPokemon,
                child: const Text("Buscar")),
            if (pokemon != null) ...[
              Image.network(pokemon!["sprites"]["front_default"]),
              Text("Experiencia base: ${pokemon!["base_experience"]}"),
              const Text("Habilidades:"),
              for (var ability in pokemon!["abilities"])
                Text(ability["ability"]["name"]),
              ElevatedButton(
                onPressed: () =>
                    playSound(pokemon!["cries"]["latest"]),
                child: const Text("Reproducir sonido"),
              )
            ]
          ],
        ),
      ),
    );
  }
}