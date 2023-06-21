import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  Future<void> logarFirebase() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text, password: senha.text);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/logada', (Route<dynamic> route) => false);
  }

  Future<void> logarGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '172258767237-is6q5bftkq5fag7sq3bm7gd4i7njuvt7.apps.googleusercontent.com',
    );
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential authResult =
    await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/homeLogin', (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer login com o Google. Tente novamente.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
  void initState() {
    super.initState();
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
        title: Text('Página de Login'),
        backgroundColor: Colors.red,
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
            SizedBox(height: 10),
            TextField(
              controller: senha,
              obscureText: obscureText,
              decoration: InputDecoration(
                label: Text('Senha'),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: logarFirebase,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/register");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle),
                  SizedBox(width: 5),
                  Text('Caso não tenha conta, clique aqui'),

                ],
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: logarGoogle, // Adicionado o onPressed para logar com o Google
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login),
                  SizedBox(width: 5),
                  Text('Login com Google'),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/senhalogin");
              },
              child: Text('Esqueceu a Senha?'),
            ),
          ],
        ),
      ),
    );
  }
}
