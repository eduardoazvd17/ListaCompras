import 'package:flutter/material.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/componentes/lista_meus_produtos.dart';
import 'package:listacompras/componentes/mensagem_lista_vazia.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_categorias.dart';

class TelaMeusProdutos extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Lista lista;
  TelaMeusProdutos({this.usuario, this.atualizarUsuario, this.lista});

  @override
  _TelaMeusProdutosState createState() => _TelaMeusProdutosState();
}

class _TelaMeusProdutosState extends State<TelaMeusProdutos> {
  Lista lista;

  _atualizarLista() {
    setState(() {
      lista = widget.usuario.listaPorId(widget.lista.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    _atualizarLista();
    return Layout(
      title: 'Produtos da lista: ${lista.nome}',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return lista.produtos.length == 0
              ? MensagemListaVazia('Esta lista não possui nenhum produto')
              : ListaMeusProdutos(
                  usuario: widget.usuario,
                  atualizarUsuario: widget.atualizarUsuario,
                  lista: widget.lista,
                  atualizarLista: _atualizarLista,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TelaCategorias(
                usuario: widget.usuario,
                atualizarUsuario: widget.atualizarUsuario,
                lista: lista,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
