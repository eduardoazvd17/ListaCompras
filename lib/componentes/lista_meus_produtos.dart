import 'package:flutter/material.dart';
import 'package:listacompras/componentes/item_meu_produto.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';

class ListaMeusProdutos extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Function atualizarLista;
  final Lista lista;
  ListaMeusProdutos({
    this.usuario,
    this.atualizarUsuario,
    this.atualizarLista,
    this.lista,
  });

  _adicionarInformacoes(Produto produto, BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(),
    );
  }

  _deletarProduto(Produto produto, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Excluir Produto'),
            content:
                Text('Deseja realmente excluir o produto: ${produto.nome}?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    lista.removerProduto(produto);
                    usuario.adicionarLista(lista);
                    atualizarUsuario(usuario);
                    atualizarLista();
                    Navigator.of(context).pop();
                  },
                  child: Text('Sim')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Não')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista.produtos.length,
      itemBuilder: (context, index) {
        Produto produto = lista.produtos[index];
        return ItemMeuProduto(
          produto: produto,
          onDeletar: _deletarProduto,
          addInfo: _adicionarInformacoes,
        );
      },
    );
  }
}
