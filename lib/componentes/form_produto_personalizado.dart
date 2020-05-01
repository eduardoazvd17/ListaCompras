import 'dart:math';

import 'package:flutter/material.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/dados.dart';

class FormProdutoPersonalizado extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  FormProdutoPersonalizado({
    this.atualizarUsuario,
    this.usuario,
  });

  @override
  _FormProdutoPersonalizadoState createState() =>
      _FormProdutoPersonalizadoState();
}

class _FormProdutoPersonalizadoState extends State<FormProdutoPersonalizado> {
  TextEditingController nomeController = TextEditingController();
  String idCategoria;

  _enviar(BuildContext context) {
    if (nomeController.text.isEmpty || idCategoria == null) {
      return;
    }

    String nome = nomeController.text;
    String id = 'pp' + nome + Random().nextInt(999999).toString();
    Produto p = Produto(id: id, idCategoria: idCategoria, nome: nome);
    widget.usuario.adicionarProdutoPersonalizado(p);
    widget.atualizarUsuario(widget.usuario);
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
                'Novo Produto',
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
                      value: idCategoria,
                      items: Dados().categorias.map((c) {
                        if (c.id != 'pp') {
                          return DropdownMenuItem(
                            value: c.id,
                            child: Text(c.nome),
                          );
                        } else {
                          return null;
                        }
                      }).toList(),
                      onChanged: (c) {
                        setState(() {
                          idCategoria = c;
                        });
                      }),
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
                        'Enviar',
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
