import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_produto_personalizado.dart';
import 'package:listacompras/componentes/item_produto_personalizado.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/componentes/mensagem_lista_vazia.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/produto_personalizado.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/dados.dart';

class TelaProdutosPersonalizados extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Lista lista;

  TelaProdutosPersonalizados({
    this.usuario,
    this.atualizarUsuario,
    this.lista,
  });

  @override
  _TelaProdutosPersonalizadosState createState() =>
      _TelaProdutosPersonalizadosState();
}

class _TelaProdutosPersonalizadosState
    extends State<TelaProdutosPersonalizados> {
  List<ProdutoPersonalizado> produtosPersonalizados;
  final dados = Dados();

  _atualizarProdutosPersonalizados() {
    setState(() {
      produtosPersonalizados = widget.usuario.produtosPersonalizados;
    });
  }

  @override
  Widget build(BuildContext context) {
    _atualizarProdutosPersonalizados();
    return Layout(
      floatingActionButton: FloatingActionButton(
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
              usuario: widget.usuario,
              atualizarUsuario: widget.atualizarUsuario,
              atualizarProdutosPersonalizados: _atualizarProdutosPersonalizados,
              produto: null,
            ),
          );
        },
      ),
      title: 'Produtos Personalizados',
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (produtosPersonalizados.length == 0) {
            return MensagemListaVazia(
                'Nenhum produto personalizado encontrado. Utilize o botão no canto inferior direito para criar.');
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                itemCount: produtosPersonalizados.length,
                itemBuilder: (context, index) {
                  Produto produto = Produto.fromProdutoPersonalizado(
                      produtosPersonalizados[index]);
                  return ItemProdutoPersonalizado(
                    produto: produto,
                    usuario: widget.usuario,
                    atualizarUsuario: widget.atualizarUsuario,
                    atualizarProdutosPersonalizados:
                        _atualizarProdutosPersonalizados,
                    lista: widget.lista,
                    valor: widget.lista.verificarExistencia(produto),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
