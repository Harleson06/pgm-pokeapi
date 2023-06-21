import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MeuPokemon extends StatefulWidget {
  final String? userEmail;

  MeuPokemon({required this.userEmail});

  @override
  _MeuPokemonState createState() => _MeuPokemonState();
}

class _MeuPokemonState extends State<MeuPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pokémon'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pokemon')
            .where('usuario', isEqualTo: widget.userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pokemon = snapshot.data!.docs;

            return ListView.builder(
              itemCount: pokemon.length,
              itemBuilder: (context, index) {
                final livro = pokemon[index].data() as Map<String, dynamic>;
                final tipo = livro['tipo'] ?? '';
                final forca = livro['forca'] ?? '';
                final nome = livro['nome'] ?? '';

                return ListTile(
                  title: Text(nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tipo: $tipo'),
                      Text('forca: $forca'),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar os Pokémon');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
