import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_produto_personalizado.dart';
import 'package:listacompras/componentes/item_produto.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/componentes/mensagem_lista_vazia.dart';
import 'package:listacompras/modelos/categoria.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/dados.dart';

class TelaProdutos extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Lista lista;
  final Categoria categoria;
  final dados = Dados();
  TelaProdutos(
      {this.usuario, this.atualizarUsuario, this.lista, this.categoria});
  @override
  Widget build(BuildContext context) {
    return Layout(
      floatingActionButton: categoria.id == 'pp'
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => FormProdutoPersonalizado(
                    usuario: usuario,
                    atualizarUsuario: atualizarUsuario,
                  ),
                );
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
      title: categoria.nome,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool exibir = false;
          if (categoria.id == 'pp') {
            if (usuario.produtosPersonalizados.length == 0) {
              return MensagemListaVazia(
                  'Nenhum produto personalizado encontrado. Utilize o botão no canto inferior direito para criar.');
            } else {
              exibir = true;
            }
          } else {
            exibir = true;
          }
          return exibir
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ListView.builder(
                    itemCount: categoria.id == 'pp'
                        ? usuario.produtosPersonalizados.length
                        : dados.produtosPorCategoria(categoria).length,
                    itemBuilder: (context, index) {
                      Produto produto = categoria.id == 'pp'
                          ? usuario.produtosPersonalizados[index]
                          : dados.produtosPorCategoria(categoria)[index];
                      return ItemProduto(
                        produto: produto,
                        usuario: usuario,
                        atualizarUsuario: atualizarUsuario,
                        lista: lista,
                        valor: lista.verificarExistencia(produto),
                      );
                    },
                  ),
                )
              : null;
        },
      ),
    );
  }
}
