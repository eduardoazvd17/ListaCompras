import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_informacoes_produtos.dart';
import 'package:listacompras/componentes/item_meu_produto.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/dados.dart';
import 'package:listacompras/utilitarios/validador.dart';

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
      builder: (_) => FormInformacoesProdutos(
        usuario: usuario,
        atualizarUsuario: atualizarUsuario,
        atualizarLista: atualizarLista,
        lista: lista,
        produto: produto,
      ),
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
    var v = Validador(context);
    v.mostrarDialogoSN(
      titulo: 'Excluir Produto',
      mensagem:
          'Deseja realmente excluir o produto: ${produto.nome}?\n\nCategoria: ${Dados().categorias.where((c) => c.id == produto.idCategoria).toList()[0].nome}',
      sim: () {
        lista.removerProduto(produto);
        usuario.adicionarLista(lista);
        atualizarUsuario(usuario);
        atualizarLista();
        Navigator.of(context).pop();
      },
      nao: () {
        Navigator.of(context).pop();
      },
    );
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
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            c.nome,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              //color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 1.0,
                        ),
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
