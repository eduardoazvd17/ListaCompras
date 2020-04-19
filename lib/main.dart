import 'package:flutter/material.dart';
import 'package:listacompras/telas/tela_navegacao.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaNavegacao(),
    );
  }
}
