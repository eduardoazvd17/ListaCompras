import 'package:flutter/material.dart';
import 'package:listacompras/modelos/descricao.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/prefixo.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';

class FormInformacoesProdutos extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Function atualizarLista;
  final Lista lista;
  final Produto produto;
  FormInformacoesProdutos({
    this.atualizarUsuario,
    this.atualizarLista,
    this.lista,
    this.produto,
    this.usuario,
  });

  @override
  _FormInformacoesProdutosState createState() => produto.descricao == null
      ? _FormInformacoesProdutosState(
          TextEditingController(),
          0,
          TextEditingController(),
          'x',
        )
      : _FormInformacoesProdutosState(
          TextEditingController(text: produto.descricao.descricao),
          produto.descricao.quantidade,
          TextEditingController(
            text: produto.descricao.preco == null
                ? ''
                : produto.descricao.preco.toStringAsFixed(2),
          ),
          produto.descricao.prefixo,
        );
}

class _FormInformacoesProdutosState extends State<FormInformacoesProdutos> {
  TextEditingController descricaoController;
  String prefixo;
  int quantidade;
  TextEditingController precoController;
  _FormInformacoesProdutosState(this.descricaoController, this.quantidade,
      this.precoController, this.prefixo);

  _salvar(BuildContext context) {
    String valor = precoController.text.replaceAll(',', '.');
    widget.produto.descricao = Descricao(
      descricao: descricaoController.text,
      quantidade: quantidade,
      preco: double.tryParse(valor),
      prefixo: prefixo,
    );
    widget.lista.adicionarProduto(widget.produto);
    widget.usuario.adicionarLista(widget.lista);
    widget.atualizarUsuario(widget.usuario);
    widget.atualizarLista();
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
                '${widget.produto.nome}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              Text(
                  'As informações abaixo são opcionais para orientação e controle de gastos.'),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                maxLength: 255,
                textCapitalization: TextCapitalization.sentences,
                controller: descricaoController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.description),
                  hintText: "Descreva seu produto...",
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    'Quantidade: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (quantidade >= 99) {
                            return;
                          }
                          quantidade++;
                        });
                      }),
                  Text(
                    quantidade.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantidade <= 0) {
                            return;
                          }
                          quantidade--;
                        });
                      }),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    'Tipo de Quantidade: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton(
                      value: prefixo,
                      items: Prefixo.values.map((p) {
                        return DropdownMenuItem(
                          value: p.toString().replaceAll('Prefixo.', ''),
                          child: Text(
                            p.toString().replaceAll('Prefixo.', '') == 'x'
                                ? 'Unidades'
                                : p.toString().replaceAll('Prefixo.', '') ==
                                        'kg'
                                    ? 'Quilos'
                                    : 'Litros',
                          ),
                        );
                      }).toList(),
                      onChanged: (p) {
                        setState(() {
                          prefixo = p;
                        });
                      }),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: precoController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.attach_money),
                  hintText: "Insira o valor unitário...",
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      onPressed: () => _salvar(context),
                      child: Text(
                        'Salvar',
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
