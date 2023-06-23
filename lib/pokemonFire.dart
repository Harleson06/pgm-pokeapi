import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projeto_livre/pokemonDetails.dart';

class PokemonFire extends StatefulWidget {
  final String pokemonType;

  const PokemonFire({Key? key, required this.pokemonType}) : super(key: key);

  @override
  _PokemonFireState createState() => _PokemonFireState();
}

class _PokemonFireState extends State<PokemonFire> {
  List<dynamic> pokemonList = [];

  Future<void> fetchPokemonData() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/type/fire'));
    if (response.statusCode == 200) {
      setState(() {
        final jsonData = json.decode(response.body);
        pokemonList = jsonData['pokemon'];
      });
    }
  }

  String getPokemonImageUrl(int pokemonId) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';
  }

  Future<void> navigateToPokemonDetails(dynamic pokemon) async {
    final response = await http.get(Uri.parse(pokemon['url']));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final pokemonDetails = {
        'id': jsonData['id'],
        'name': jsonData['name'],
        'type': jsonData['types'][0]['type']['name'],
        'height': jsonData['height'],
        'weight': jsonData['weight'],
        'abilities': jsonData['abilities'].map((ability) => ability['ability']['name']).toList(),
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetails(pokemon: pokemonDetails),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemons Fire'),
      ),
      body: ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = pokemonList[index]['pokemon'];
          final pokemonId = pokemonList[index]['pokemon']['url'].split('/')[6];
          final pokemonImageUrl = getPokemonImageUrl(int.parse(pokemonId));

          return ListTile(
            leading: Image.network(
              pokemonImageUrl,
              width: 50,
              height: 50,
            ),
            title: Text(pokemon['name']),
            onTap: () {
              navigateToPokemonDetails(pokemon);
            },
          );
        },
      ),
    );
  }
}
