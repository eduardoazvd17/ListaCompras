import 'package:flutter/material.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/usuario.dart';

class TelaMeusProdutos extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Lista lista;
  TelaMeusProdutos({this.usuario, this.atualizarUsuario, this.lista});
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: lista.nome,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Text('meus produtos'),
          );
        },
      ),
    );
  }
}
