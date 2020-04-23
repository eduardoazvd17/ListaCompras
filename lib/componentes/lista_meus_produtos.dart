import 'package:flutter/material.dart';
import 'package:listacompras/componentes/item_meu_produto.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/dados.dart';

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

  _marcarProduto(Produto produto, BuildContext context) {
    produto.isComprado = !produto.isComprado;
    lista.adicionarProduto(produto);
    usuario.adicionarLista(lista);
    atualizarUsuario(usuario);
    atualizarLista();
  }

  _deletarProduto(Produto produto, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Excluir Produto'),
            content: Text(
                'Deseja realmente excluir o produto: ${produto.nome} da categoria: ${Dados().categorias.where((c) => c.id == produto.idCategoria).toList()[0].nome}?'),
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
                child: Text('Não'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Produto>> produtosPorCategoria =
        lista.produtosPorCategoria();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: Dados().categorias.map(
            (c) {
              List<Produto> produtos = produtosPorCategoria[c.id];
              if (produtos.length > 0) {
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          c.nome,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: produtos.map(
                            (p) {
                              return ItemMeuProduto(
                                produto: p,
                                onDeletar: _deletarProduto,
                                addInfo: _adicionarInformacoes,
                                onTap: _marcarProduto,
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ).toList(),
        ),
      ),
    );
  }
}
