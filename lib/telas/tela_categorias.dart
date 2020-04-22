import 'package:flutter/material.dart';
import 'package:listacompras/componentes/item_categoria.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/modelos/categoria.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_produtos.dart';
import 'package:listacompras/utilitarios/dados.dart';

class TelaCategorias extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Lista lista;
  final dados = Dados();
  TelaCategorias({this.lista, this.atualizarUsuario, this.usuario});

  _abrirCategoria(Categoria categoria, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TelaProdutos(
          usuario: usuario,
          atualizarUsuario: atualizarUsuario,
          categoria: categoria,
          lista: lista,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Categorias',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ListView.builder(
              itemCount: dados.categorias.length,
              itemBuilder: (context, index) {
                Categoria categoria = dados.categorias[index];
                return ItemCategoria(
                  categoria: categoria,
                  onTap: _abrirCategoria,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
