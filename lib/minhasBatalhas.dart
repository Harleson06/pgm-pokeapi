import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MinhasBatalhas extends StatefulWidget {
  final String userEmail;

  const MinhasBatalhas({Key? key, required this.userEmail}) : super(key: key);

  @override
  _MinhasBatalhasState createState() => _MinhasBatalhasState();
}

class _MinhasBatalhasState extends State<MinhasBatalhas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Batalhas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('batalhas')
            .where('usuario', isEqualTo: widget.userEmail)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Erro ao carregar as batalhas');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var nome = data['nome'];
              var resultado = data['resultado'];

              return ListTile(
                title: Text(nome),
                subtitle: Text('Resultado: $resultado'),
              );
            },
          );
        },
      ),
    );
  }
}
