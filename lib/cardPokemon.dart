import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardPokemon extends StatelessWidget {
  final String pokemonName;
  final String pokemonImage;

  const CardPokemon({
    required this.pokemonName,
    required this.pokemonImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pokémon'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pokemonName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Image.network(pokemonImage),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final url = 'https://example.com/cardgame/$pokemonName';
                launchURL(url);
              },
              child: Text('Jogar CardGame'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
