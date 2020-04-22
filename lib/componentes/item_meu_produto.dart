import 'package:flutter/material.dart';
import 'package:listacompras/modelos/produto.dart';

class ItemMeuProduto extends StatelessWidget {
  final Produto produto;
  final Function onDeletar;
  final Function addInfo;
  ItemMeuProduto({this.produto, this.onDeletar, this.addInfo});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            produto.nome,
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
                onPressed: () => addInfo(produto, context),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => onDeletar(produto, context),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
