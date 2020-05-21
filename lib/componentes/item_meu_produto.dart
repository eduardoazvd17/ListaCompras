import 'package:flutter/material.dart';
import 'package:listacompras/modelos/informacoes.dart';
import 'package:listacompras/modelos/produto.dart';

class ItemMeuProduto extends StatelessWidget {
  final Produto produto;
  final Function onDeletar;
  final Function addInfo;
  final Function onTap;
  ItemMeuProduto({this.produto, this.onDeletar, this.addInfo, this.onTap});

  Widget _formarSubtitulo(Informacoes i) {
    String qtd = '', unt = '', tot = '';
    bool q = false, u = false, t = false;
    String qtdString = i.prefixo == 'x'
        ? i.quantidade.toStringAsFixed(0)
        : i.quantidade.toStringAsFixed(1);
    if (i.quantidade != 0) {
      qtd = 'Quantidade: ' + qtdString + i.prefixo;
      q = true;
    }
    if (i.preco != null || double.tryParse(i.preco.toString()) != null) {
      unt = 'Valor unitário: R\$' + i.preco.toStringAsFixed(2);
      u = true;
    }
    if (i.quantidade != 0 && i.preco != null) {
      tot = 'Total: R\$' + (i.quantidade * i.preco).toStringAsFixed(2);
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
          isThreeLine: produto.informacoes == null
              ? false
              : produto.informacoes.quantidade != 0 &&
                      (produto.informacoes.preco != null ||
                          double.tryParse(
                                  produto.informacoes.preco.toString()) !=
                              null)
                  ? true
                  : false,
          subtitle: produto.informacoes == null
              ? null
              : (produto.informacoes.quantidade != 0 &&
                          (produto.informacoes.preco != null ||
                              double.tryParse(
                                      produto.informacoes.preco.toString()) !=
                                  null)) ||
                      (produto.informacoes.preco != null ||
                          double.tryParse(
                                  produto.informacoes.preco.toString()) !=
                              null) ||
                      produto.informacoes.quantidade != 0
                  ? _formarSubtitulo(produto.informacoes)
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
