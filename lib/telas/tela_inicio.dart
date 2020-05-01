import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_cadastro.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_pin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicio extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  TelaInicio({this.usuario, this.atualizarUsuario});

  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  final emailController = TextEditingController();

  _entrar(bool isAutomatico) async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      return;
    }

    if (!email.contains(RegExp('@.'))) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('E-mail Inválido'),
              content: Text('Digite um endereço de e-mail válido.'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            );
          });
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(height: 15),
                new Text(
                  "Entrando...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    DocumentSnapshot doc =
        await Firestore.instance.collection('usuarios').document(email).get();

    if (doc.data == null) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('E-mail Não Cadastrado'),
              content: Text(
                  'Este endereço de e-mail não está cadastrado, utilize o formulário de cadastro clicando em "Ainda não possui uma conta?".'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Theme.of(context).accentColor),
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

    Navigator.of(context).pop();

    if (isAutomatico) {
      widget.atualizarUsuario(u);
    } else {
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
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.usuario == null) {
      SharedPreferences.getInstance().then((prefs) {
        if (i == 0) {
          i++;
          String email = prefs.getString('email');
          if (email != null || email.isNotEmpty) {
            emailController.text = email;
            _entrar(true);
          }
        }
      });
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return widget.usuario == null
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
                                    onPressed: () => _entrar(false),
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
                      FlutterLogo(
                          size: MediaQuery.of(context).size.width * 0.25),
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
