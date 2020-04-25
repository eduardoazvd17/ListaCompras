import 'package:flutter/material.dart';
import 'package:listacompras/telas/tela_splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
      ),
      home: TelaSplash(),
    );
  }
}
