import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/componentes/item_ajuda.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/validador.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicio extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  TelaInicio({this.usuario, this.atualizarUsuario});

  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  int _carouselIndex = 0;
  var _carouselItems = [
    ItemAjuda(
      'Criação de listas',
      'Para criar suas listas de compras, utilize a barra de navegação na parte inferior do app para ir à tela de listas, clique no botão flutuante no canto inferior direito e preencha o forumlário para criar sua lista.',
    ),
    ItemAjuda(
      'Adição de produtos',
      'Para adicionar produtos à lista, clique na lista desejada e após clique no botão flutuante para exibir a tela de categorias, após isso selecione a categoria desejada e marque os produtos para ser adicionado à lista.',
    ),
    ItemAjuda(
      'Produtos personalizados',
      'Caso não encontre um produto específico, você poderá adicioná-lo manualmente. Para fazer isso, na tela de categoria role a lista até o final e selecione a categoria "Produtos Personalizados", após isso clique no botão flutuante e preencha o formulário para adicionar. O produto aparecerá nessa categoria e também na categoria em que foi preenchida no formulário.',
    ),
    ItemAjuda(
      'Informações Adicionais',
      'Para adicionar informações adicionais aos produtos como descrição, quantidade e preço, na sua lista, clique no icone de mais opções do produto desejado e preencha o formulário.',
    ),
  ];
  final nomeController = TextEditingController();

  _entrar() async {
    var v = Validador(context);
    String nome = nomeController.text.trim();

    if (v.isVazio(nome)) {
      return;
    }

    v.mostrarCarregamento('Entrando...');

    var prefs = await SharedPreferences.getInstance();
    Usuario u = Usuario(nome: nome);
    prefs.setString('usuario', json.encode(u.toJson()));
    widget.atualizarUsuario(u);

    v.ocultarCarregamento();
  }

  String _formarComunicacao() {
    int horaAtual = DateTime.now().hour;
    if (horaAtual >= 0 && horaAtual <= 5) {
      return 'Boa madrugada.';
    } else if (horaAtual >= 6 && horaAtual <= 11) {
      return 'Bom dia.';
    } else if (horaAtual >= 12 && horaAtual <= 17) {
      return 'Boa tarde.';
    } else {
      return 'Boa noite.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return widget.usuario == null
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: MediaQuery.of(context).size.height * 0.15,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 30),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Olá! Seja bem vindo.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Se já possui uma conta, insira seu e-mail no formulário abaixo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.0,
                          ),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                textCapitalization: TextCapitalization.words,
                                controller: nomeController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.mail),
                                  hintText: "Insira seu nome...",
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () => _entrar(),
                                    child: Text(
                                      'Entrar',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: MediaQuery.of(context).size.height * 0.15,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 30),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Olá ${widget.usuario.nome.split(' ').first}! ${_formarComunicacao()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 15),
                                Divider(),
                                SizedBox(height: 15),
                                Center(
                                  child: Text(
                                    'Precisa de ajuda? Utilize o slide abaixo.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Divider(),
                                SizedBox(height: 15),
                                CarouselSlider(
                                  items: _carouselItems,
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _carouselIndex = index;
                                      });
                                    },
                                    height: 250,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.9,
                                    aspectRatio: 16 / 9,
                                    initialPage: 0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _carouselItems.map((item) {
                                    int index = _carouselItems.indexOf(item);
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _carouselIndex == index
                                            ? Theme.of(context).primaryColor
                                            : Color.fromRGBO(0, 0, 0, 0.3),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
