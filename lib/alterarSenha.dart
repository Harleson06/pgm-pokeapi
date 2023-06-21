import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SenhaScreen extends StatefulWidget {
  const SenhaScreen({Key? key}) : super(key: key);

  @override
  State<SenhaScreen> createState() => _SenhaScreenState();
}

class _SenhaScreenState extends State<SenhaScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  Future<void> resetPasswordFirebase() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('E-mail de redefinição enviado'),
          content: Text('Um e-mail com as instruções para redefinir sua senha foi enviado para ${email.text}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Troca de Senha'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: senha,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/register");
              },
              child: Text('Caso não tenha conta, clique aqui'),
            ),
            SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  resetPasswordFirebase();
                },
                child: Text('Receber e-mail de Alteração')
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}