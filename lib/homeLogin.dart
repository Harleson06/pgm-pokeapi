import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_livre/PokedexScreen.dart';
import 'package:projeto_livre/meuPokemon.dart';
import 'package:projeto_livre/minhasBatalhas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeLogin extends StatelessWidget {
  const HomeLogin({Key? key}) : super(key: key);

  Future<void> deslogarFirebase(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Logada'),
        actions: [
          GestureDetector(
            onTap: () => deslogarFirebase(context),
            child: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Meus Pokémon'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeuPokemon(
                      userEmail: userEmail!,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Minhas Batalhas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MinhasBatalhas(
                      userEmail: userEmail!,
                    ),
                  ),
                );
              },
            ),
            // Adicione quantos ListTile quiser para representar as opções do menu
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/HomeLoginScreen.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PokedexScreen()),
                        );
                      },
                      child: Text('Ir para Arena Pokémon'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
