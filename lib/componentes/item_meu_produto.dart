import 'package:flutter/material.dart';

class ItemMeuProduto extends StatelessWidget {
  final String nome;
  final Function onAdicionarInformacoes;
  final Function onDeletar;
  ItemMeuProduto({this.nome, this.onDeletar, this.onAdicionarInformacoes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            nome,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_comment,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: onAdicionarInformacoes,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDeletar,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
