import 'package:flutter/material.dart';

class ItemProduto extends StatefulWidget {
  final String nome;
  final bool valor;
  ItemProduto({this.nome, this.valor});

  @override
  _ItemProdutoState createState() =>
      _ItemProdutoState(valor == null ? false : valor);
}

class _ItemProdutoState extends State<ItemProduto> {
  bool valor;
  _ItemProdutoState(this.valor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text(
            widget.nome,
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
