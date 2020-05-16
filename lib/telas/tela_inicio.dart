import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_cadastro.dart';
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
                            'Olá ${widget.usuario.nome.split(' ').first}! Bem vindo de volta.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
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
