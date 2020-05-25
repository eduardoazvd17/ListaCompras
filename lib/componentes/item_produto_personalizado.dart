import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_produto_personalizado.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/produto_personalizado.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/dados.dart';
import 'package:listacompras/utilitarios/validador.dart';

class ItemProdutoPersonalizado extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Function atualizarProdutosPersonalizados;
  final Lista lista;
  final Produto produto;
  final bool valor;
  ItemProdutoPersonalizado({
    this.usuario,
    this.atualizarUsuario,
    this.lista,
    this.produto,
    this.valor,
    this.atualizarProdutosPersonalizados,
  });
  @override
  _ItemProdutoPersonalizadoState createState() =>
      _ItemProdutoPersonalizadoState(valor == null ? false : this.valor);
}

class _ItemProdutoPersonalizadoState extends State<ItemProdutoPersonalizado> {
  bool valor;
  _ItemProdutoPersonalizadoState(this.valor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text(
            widget.produto.nome,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Dados()
                  .categorias
                  .where((c) => c.id == widget.produto.idCategoria)
                  .first
                  .nome),
            ],
          ),
          controlAffinity: ListTileControlAffinity.leading,
          secondary: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
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
                      atualizarProdutosPersonalizados:
                          widget.atualizarProdutosPersonalizados,
                      produto: widget.produto,
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  var v = Validador(context);
                  v.mostrarDialogoSN(
                    titulo: 'Excluir Produto',
                    mensagem:
                        'Deseja realmente excluir o produto personalizado: ${widget.produto.nome}?',
                    sim: () {
                      widget.usuario.removerProdutoPersonalizado(
                          ProdutoPersonalizado.fromProduto(widget.produto));
                      widget.atualizarUsuario(widget.usuario);
                      widget.atualizarProdutosPersonalizados();
                      Navigator.of(context).pop();
                    },
                    nao: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ],
          ),
          value: valor,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (valor) {
            setState(() {
              this.valor = valor;
            });
            if (valor) {
              widget.lista.adicionarProduto(widget.produto);
            } else {
              widget.lista.removerProduto(widget.produto);
            }
            widget.usuario.adicionarLista(widget.lista);
            widget.atualizarUsuario(widget.usuario);
          },
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
