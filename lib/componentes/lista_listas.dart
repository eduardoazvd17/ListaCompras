import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_lista.dart';
import 'package:listacompras/componentes/item_lista.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_meus_produtos.dart';
import 'package:listacompras/utilitarios/validador.dart';

class ListaListas extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  ListaListas({this.usuario, this.atualizarUsuario});

  _editarLista(Lista lista, BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) => FormLista(
        usuario: usuario,
        atualizarUsuario: atualizarUsuario,
        lista: lista,
      ),
    );
  }

  _abrirLista(Lista lista, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TelaMeusProdutos(
          usuario: usuario,
          atualizarUsuario: atualizarUsuario,
          lista: lista,
        ),
      ),
    );
  }

  _deletarLista(Lista lista, BuildContext context) {
    var v = Validador(context);
    v.mostrarDialogoSN(
      titulo: 'Excluir Lista',
      mensagem: 'Deseja realmente excluir a lista: ${lista.nome}?',
      sim: () {
        usuario.removerLista(lista);
        atualizarUsuario(usuario);
        Navigator.of(context).pop();
      },
      nao: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usuario.listasDeCompras.length,
      itemBuilder: (context, index) {
        Lista lista = usuario.listasDeCompras[index];
        return ItemLista(
          lista: lista,
          onDeletar: _deletarLista,
          onEditar: _editarLista,
          onTap: _abrirLista,
        );
      },
    );
  }
}
