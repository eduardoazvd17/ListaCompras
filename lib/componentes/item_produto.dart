import 'package:flutter/material.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';

class ItemProduto extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Lista lista;
  final Produto produto;
  final bool valor;
  ItemProduto({
    this.usuario,
    this.atualizarUsuario,
    this.lista,
    this.produto,
    this.valor,
  });
  @override
  _ItemProdutoState createState() => _ItemProdutoState(this.valor);
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
            widget.produto.nome.replaceAll('zzz', ''),
            overflow: TextOverflow.ellipsis,
          ),
          value: valor,
          onChanged: (valor) {
            setState(() {
              this.valor = valor;
            });
            if (valor) {
              widget.lista.adicionarProduto(widget.produto);
            } else {
              widget.lista.removerProduto(widget.produto);
            }
            widget.usuario.adicionarLista(widget.lista);
            widget.atualizarUsuario(widget.usuario);
          },
        ),
        Divider(),
      ],
    );
  }
}
