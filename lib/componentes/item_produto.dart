import 'package:flutter/material.dart';

class ItemProduto extends StatefulWidget {
  @override
  _ItemProdutoState createState() => _ItemProdutoState();
}

class _ItemProdutoState extends State<ItemProduto> {
  bool valor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text(
            'produto',
            overflow: TextOverflow.ellipsis,
          ),
          value: valor,
          onChanged: (valor) {
            setState(() {
              this.valor = valor;
            });
          },
        ),
        Divider(),
      ],
    );
  }
}
