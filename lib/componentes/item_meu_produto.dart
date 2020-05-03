import 'package:flutter/material.dart';
import 'package:listacompras/modelos/descricao.dart';
import 'package:listacompras/modelos/produto.dart';

class ItemMeuProduto extends StatelessWidget {
  final Produto produto;
  final Function onDeletar;
  final Function addInfo;
  final Function onTap;
  ItemMeuProduto({this.produto, this.onDeletar, this.addInfo, this.onTap});

  Widget _formarSubtitulo(Descricao d) {
    String qtd = '', unt = '', tot = '';
    bool q = false, u = false, t = false;

    if (d.quantidade != 0) {
      qtd = 'Quantidade: ' + d.quantidade.toString() + d.prefixo;
      q = true;
    }
    if (d.preco != null || double.tryParse(d.preco.toString()) != null) {
      unt = 'Valor unitário: R\$' + d.preco.toStringAsFixed(2);
      u = true;
    }
    if (d.quantidade != 0 && d.preco != null) {
      tot = 'Total: R\$' + (d.quantidade * d.preco).toStringAsFixed(2);
      t = true;
    }

    String resultado = '';

    if (q && u && t) {
      resultado = '$unt\n$qtd\n$tot';
    } else if (q && !u && !t) {
      resultado = '$qtd';
    } else if (!q && u && !t) {
      resultado = '$unt';
    }
    return Text(resultado);
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          isThreeLine: produto.descricao == null
              ? false
              : produto.descricao.quantidade != 0 &&
                      (produto.descricao.preco != null ||
                          double.tryParse(produto.descricao.preco.toString()) !=
                              null)
                  ? true
                  : false,
          subtitle: produto.descricao == null
              ? null
              : (produto.descricao.quantidade != 0 &&
                          (produto.descricao.preco != null ||
                              double.tryParse(
                                      produto.descricao.preco.toString()) !=
                                  null)) ||
                      (produto.descricao.preco != null ||
                          double.tryParse(produto.descricao.preco.toString()) !=
                              null) ||
                      produto.descricao.quantidade != 0
                  ? _formarSubtitulo(produto.descricao)
                  : null,
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
        Divider(
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }
}
