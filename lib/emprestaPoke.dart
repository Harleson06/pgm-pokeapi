import 'package:flutter/material.dart';

class EmprestaPoke extends StatelessWidget {
  final String pokemonName;
  final void Function(String) onEmprestar;

  const EmprestaPoke({
    Key? key,
    required this.pokemonName,
    required this.onEmprestar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Emprestar Pokémon'),
      content: Text('Deseja emprestar o Pokémon: $pokemonName?'),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Emprestar'),
          onPressed: () {
            onEmprestar(pokemonName);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
