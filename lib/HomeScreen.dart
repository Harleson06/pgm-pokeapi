import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projeto_livre/pokedexScreen.dart';
import 'PokemonMaps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Uri url = Uri(scheme: 'https', host: 'www.pokemon.com');
  String userEmailValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Troca e Batalhas de Pokemon'),
        backgroundColor: Colors.red,
        actions: [
          PopupMenuButton(
            tooltip: 'Acessar Menu',
            onSelected: (String value) {
              if (value == 'login') {
                Navigator.of(context).pushNamed('/login');
              } else if (value == 'register') {
                Navigator.of(context).pushNamed('/register');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 'login',
                  child: ListTile(leading: Icon(Icons.login),
                  title: Text('Pagina de login'),
                ),
                ),
                const PopupMenuItem(value: 'register', child: ListTile(leading: Icon(Icons.person_add),
              title: Text('Pagina de Cadastro'),
              ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/apipoke.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PokedexScreen()));
                },
                child: Container(
                  width: 600,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      'Ir para Feira de Pokemons',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  const url = 'https://www.pokemon.com';
                  launchURL(url);
                },
                child: Container(
                  width: 600,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      'Fique por dentro das Ultimas Noticias do Mundo Pokemon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
