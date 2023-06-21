import 'package:flutter/material.dart';

class PokemonDetails extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  const PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon['name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon['id']}.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 16),
            Text('Type: ${pokemon['type']}'),
            SizedBox(height: 8),
            Text('Height: ${pokemon['height']}'),
            SizedBox(height: 8),
            Text('Weight: ${pokemon['weight']}'),
            SizedBox(height: 8),
            Text('Abilities: ${pokemon['abilities'].join(", ")}'),
          ],
        ),
      ),
    );
  }
}
