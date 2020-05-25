import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_cadastro.dart';
import 'package:listacompras/componentes/item_ajuda.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_pin.dart';
import 'package:listacompras/utilitarios/validador.dart';

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
  final emailController = TextEditingController();

  _entrar() async {
    var v = Validador(context);
    String email = emailController.text.trim();

    if (v.isVazio(email)) {
      return;
    }

    if (!v.isEmail(email)) {
      v.mostrarDialogoOK(
          'E-mail Inválido', 'Digite um endereço de e-mail válido.');
      return;
    }

    v.mostrarCarregamento('Entrando...');

    var conn = await Connectivity().checkConnectivity();
    if (conn == ConnectivityResult.none) {
      v.ocultarCarregamento();
      v.mostrarDialogoOK('Conexão Indisponível',
          'Sem conexão com a internet, ative o wifi ou os dados móveis para continuar.');
      return;
    }

    DocumentSnapshot doc =
        await Firestore.instance.collection('usuarios').document(email).get();

    if (doc.data == null) {
      v.ocultarCarregamento();
      v.mostrarDialogoOK('E-mail Não Cadastrado',
          'Este endereço de e-mail não está cadastrado, utilize o formulário de cadastro clicando em "Ainda não possui uma conta?".');
      return;
    }

    Usuario u = Usuario.fromJson(
      doc['dados'],
    );

    v.ocultarCarregamento();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TelaPin(
          usuario: u,
          atualizarUsuario: widget.atualizarUsuario,
          pin: doc['pin'],
        ),
      ),
    );
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
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.mail),
                                  hintText: "Insira seu e-mail...",
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(40),
                                  ),
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (_) => FormCadastro(
                                  atualizarUsuario: widget.atualizarUsuario,
                                ),
                              );
                            },
                            child: Text(
                              'Ainda não possui uma conta?',
                            ),
                          ),
                        ],
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
                                    height: 200,
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
