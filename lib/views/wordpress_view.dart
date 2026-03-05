import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class WordPressView extends StatefulWidget {
  const WordPressView({super.key});

  @override
  State<WordPressView> createState() => _WordPressViewState();
}

class _WordPressViewState extends State<WordPressView> {
  List posts = [];

  Future<void> fetchPosts() async {
    final response = await http.get(
      Uri.parse("https://techcrunch.com/wp-json/wp/v2/posts?per_page=3"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      posts = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Noticias WordPress")),
      body: ListView(
        children: [
          Image.network(
              "https://techcrunch.com/wp-content/uploads/2015/02/cropped-cropped-favicon-gradient.png"),
          for (var post in posts)
            Card(
              child: ListTile(
                title: Text(post["title"]["rendered"]),
                subtitle: Text(
                  post["excerpt"]["rendered"]
                      .replaceAll(RegExp(r'<[^>]*>'), ''),
                ),
                trailing: const Text("Visitar"),
                onTap: () => openUrl(post["link"]),
              ),
            )
        ],
      ),
    );
  }
}