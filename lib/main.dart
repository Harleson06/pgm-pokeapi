import 'package:flutter/material.dart';
import 'package:projeto_livre/alterarSenha.dart';
import 'package:projeto_livre/homeScreen.dart';
import 'package:projeto_livre/loginScreen.dart';
import 'package:projeto_livre/homeLogin.dart';
import 'package:projeto_livre/pokemonWater.dart';
import 'package:projeto_livre/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'PokemonMaps.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      "/home": (_) => HomeScreen(),
      "/login": (_) => LoginScreen(),
      "/register": (_) => RegisterScreen(),
      "/logada": (_) => HomeLogin(),
      "/senhalogin": (_) => SenhaScreen(),
      '/water': (_) => PokemonWater(pokemonType: '',),
      '/mapa': (_) => BookLocalizationScreen(),
    },
  ));
}


