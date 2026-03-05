import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {

  Map<String, dynamic>? weatherData;
  String? error;

  Future<void> fetchWeather() async {

    try {

      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=Santo Domingo,DO&appid=f82c0ae5101089d3f8e8add213a2d29f&units=metric&lang=es"
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data["main"] != null && data["weather"] != null) {
          setState(() {
            weatherData = data;
          });
        } else {
          setState(() {
            error = "Datos del clima no disponibles";
          });
        }

      } else {
        setState(() {
          error = "Error al consultar la API";
        });
      }

    } catch (e) {
      setState(() {
        error = "Error de conexión";
      });
    }

  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {

    String date = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text("Clima en RD")),
      body: Center(
        child: weatherData == null
            ? error != null
                ? Text(error!)
                : const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(date, style: const TextStyle(fontSize: 18)),

                  const SizedBox(height: 20),

                  Text(
                    "Temperatura: ${weatherData!["main"]["temp"]} °C",
                    style: const TextStyle(fontSize: 22),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Estado: ${weatherData!["weather"][0]["description"]}",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  Image.network(
                    "https://openweathermap.org/img/wn/${weatherData!["weather"][0]["icon"]}@2x.png",
                  ),
                ],
              ),
      ),
    );
  }
}