import 'package:flutter/material.dart';
import 'package:listacompras/telas/tela_splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData light = ThemeData.light().copyWith(
      primaryColor: Colors.blue,
      accentColor: Colors.blue,
      hoverColor: Colors.blue,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue),
    );
    ThemeData dark = ThemeData.dark().copyWith(
      primaryColor: Colors.blue,
      accentColor: Colors.blue,
      hoverColor: Colors.blue,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue),
    );
    return GestureDetector(
      onTap: () {
        var currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Compras',
        theme: light,
        darkTheme: dark,
        home: TelaSplash(),
      ),
    );
  }
}
