import 'package:flutter/material.dart';
import 'package:listacompras/componentes/layout.dart';

class TelaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Categorias',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Text('Inicio'),
          );
        },
      ),
    );
  }
}
