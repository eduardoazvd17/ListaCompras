import 'package:flutter/material.dart';
import 'package:listacompras/modelos/produto.dart';

class ItemMeuProduto extends StatelessWidget {
  final Produto produto;
  final Function onDeletar;
  final Function addInfo;
  final Function onTap;
  ItemMeuProduto({this.produto, this.onDeletar, this.addInfo, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          isThreeLine: produto.descricao == null ? false : true,
          subtitle: produto.descricao == null
              ? null
              : Text('Valor unitário: R\$' +
                  produto.descricao.preco.toStringAsFixed(2) +
                  '\nQuantidade: ' +
                  produto.descricao.quantidade.toString() +
                  produto.descricao.prefixo +
                  '\nTotal: R\$' +
                  (produto.descricao.quantidade * produto.descricao.preco)
                      .toStringAsFixed(2)),
          title: Text(
            produto.nome,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                decoration: produto.isComprado
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          leading: produto.isComprado
              ? CircleAvatar(
                  child: Icon(
                    Icons.done,
                    color: Colors.grey,
                  ),
                  backgroundColor: Colors.transparent,
                )
              : null,
          onTap: () => onTap(produto, context),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => addInfo(produto, context),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
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
