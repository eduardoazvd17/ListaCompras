import 'package:flutter/material.dart';
import 'package:listacompras/componentes/item_produto.dart';
import 'package:listacompras/componentes/layout.dart';
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
      title: categoria.nome,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ListView.builder(
              itemCount: dados.produtosPorCategoria(categoria).length,
              itemBuilder: (context, index) {
                Produto produto = dados.produtosPorCategoria(categoria)[index];
                return ItemProduto(
                  produto: produto,
                  usuario: usuario,
                  atualizarUsuario: atualizarUsuario,
                  lista: lista,
                  valor: lista.verificarExistencia(produto),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
