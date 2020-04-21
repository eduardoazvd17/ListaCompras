import 'package:flutter/material.dart';
import 'package:listacompras/componentes/layout.dart';

class TelaProdutos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'NOME DA CATEGORIA',
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
