import 'package:flutter/material.dart';
import 'package:listacompras/telas/tela_splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData light = ThemeData.light();
    ThemeData dark = ThemeData.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      theme: light,
      darkTheme: dark,
      home: TelaSplash(),
    );
  }
}
