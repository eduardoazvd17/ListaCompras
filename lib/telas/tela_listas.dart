import 'package:flutter/material.dart';
import 'package:listacompras/componentes/item_categoria.dart';

class TelaListas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            ItemCategoria(nome: 'Frutas'),
          ],
        );
      },
    );
  }
}
