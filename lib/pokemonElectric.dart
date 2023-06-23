import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projeto_livre/pokemonDetails.dart';

class PokemonElectric extends StatefulWidget {
  final String pokemonType;

  const PokemonElectric({Key? key, required this.pokemonType}) : super(key: key);

  @override
  _PokemonElectricState createState() => _PokemonElectricState();
}

class _PokemonElectricState extends State<PokemonElectric> {
  List<dynamic> pokemonList = [];

  Future<void> fetchPokemonData() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/type/electric'));
    if (response.statusCode == 200) {
      setState(() {
        final jsonData = json.decode(response.body);
        pokemonList = jsonData['pokemon'];
      });
    } else {
      throw Exception('Failed to load Pokemon data');
    }
  }

  String getPokemonImageUrl(int pokemonId) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';
  }

  Future<void> navigateToPokemonDetails(String pokemonUrl) async {
    final response = await http.get(Uri.parse(pokemonUrl));
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
        title: Text('Pokemons Electric'),
      ),
      body: ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final pokemonUrl = pokemonList[index]['pokemon']['url'];
          final pokemonId = int.parse(pokemonUrl.split('/')[6]);
          final pokemonImageUrl = getPokemonImageUrl(pokemonId);

          return ListTile(
            leading: Image.network(
              pokemonImageUrl,
              width: 50,
              height: 50,
            ),
            title: Text(pokemonList[index]['pokemon']['name']),
            onTap: () {
              navigateToPokemonDetails(pokemonUrl);
            },
          );
        },
      ),
    );
  }
}
