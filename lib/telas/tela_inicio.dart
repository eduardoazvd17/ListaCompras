import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_cadastro.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_pin.dart';

class TelaInicio extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  TelaInicio({this.usuario, this.atualizarUsuario});
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return usuario == null
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlutterLogo(
                          size: MediaQuery.of(context).size.width * 0.25),
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
                                    onPressed: () async {
                                      String email =
                                          emailController.text.trim();

                                      if (email.isEmpty) {
                                        return;
                                      }

                                      if (!email.contains(RegExp('@.'))) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('E-mail Inválido'),
                                                content: Text(
                                                    'Digite um endereço de e-mail válido.'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Ok',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                        return;
                                      }

                                      DocumentSnapshot doc = await Firestore
                                          .instance
                                          .collection('usuarios')
                                          .document(email)
                                          .get();

                                      if (doc.data == null) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'E-mail Não Cadastrado'),
                                                content: Text(
                                                    'Este endereço de e-mail não está cadastrado, utilize o formulário de cadastro clicando em "Ainda não possui uma conta?".'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Ok',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                        return;
                                      }

                                      Usuario u = Usuario.fromJson(
                                        doc['dados'],
                                      );

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => TelaPin(
                                            usuario: u,
                                            atualizarUsuario: atualizarUsuario,
                                            pin: doc['pin'],
                                          ),
                                        ),
                                      );
                                    },
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
                                  atualizarUsuario: atualizarUsuario,
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
                      FlutterLogo(
                          size: MediaQuery.of(context).size.width * 0.25),
                      SizedBox(height: 30),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Olá ${usuario.nome.split(' ').first}! Bem vindo de volta.',
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
