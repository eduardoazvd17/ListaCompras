import 'package:flutter/material.dart';
import 'package:listacompras/componentes/lista_listas.dart';
import 'package:listacompras/componentes/mensagem_lista_vazia.dart';
import 'package:listacompras/modelos/usuario.dart';

class TelaListas extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  TelaListas({this.usuario, this.atualizarUsuario});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return usuario.listasDeCompras.length == 0
            ? MensagemListaVazia('Você não possui nenhuma lista de compras')
            : ListaListas(usuario: usuario, atualizarUsuario: atualizarUsuario);
      },
    );
  }
}
