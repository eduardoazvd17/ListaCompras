import 'dart:math';
import 'package:flutter/material.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/dados.dart';

class FormProdutoPersonalizado extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Function atualizarProdutosPersonalizados;
  final Produto produto;
  FormProdutoPersonalizado({
    this.atualizarUsuario,
    this.usuario,
    this.produto,
    this.atualizarProdutosPersonalizados,
  });

  @override
  _FormProdutoPersonalizadoState createState() => produto == null
      ? _FormProdutoPersonalizadoState(
          TextEditingController(),
          Dados().categorias.first.id,
        )
      : _FormProdutoPersonalizadoState(
          TextEditingController(text: produto.nome),
          Dados().categorias.where((c) => c.id == produto.idCategoria).first.id,
        );
}

class _FormProdutoPersonalizadoState extends State<FormProdutoPersonalizado> {
  final dados = Dados();
  TextEditingController nomeController;
  String idCategoriaSelecionada;
  _FormProdutoPersonalizadoState(
      this.nomeController, this.idCategoriaSelecionada);

  _enviar(BuildContext context) {
    if (nomeController.text.isEmpty) {
      return;
    }

    String nome = nomeController.text;
    String id = widget.produto == null
        ? 'pp' + nome + Random().nextInt(999999).toString()
        : widget.produto.id;
    Produto p =
        Produto(id: id, idCategoria: idCategoriaSelecionada, nome: nome);
    widget.usuario.adicionarProdutoPersonalizado(p);
    widget.atualizarUsuario(widget.usuario);
    widget.atualizarProdutosPersonalizados();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.produto == null ? 'Novo Produto' : 'Editar Produto',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              SizedBox(height: 10),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: nomeController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.description),
                  hintText: "Insira um nome...",
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    'Categoria: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton(
                    value: idCategoriaSelecionada,
                    items: dados.categoriasDropDown(),
                    onChanged: (c) {
                      setState(
                        () {
                          idCategoriaSelecionada = c;
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      onPressed: () => _enviar(context),
                      child: Text(
                        widget.produto == null ? 'Enviar' : 'Salvar',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ))
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
