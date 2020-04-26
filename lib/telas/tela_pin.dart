import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPin extends StatefulWidget {
  final int pin;
  final String email;
  final Function atualizarUsuario;
  TelaPin({this.atualizarUsuario, this.pin, this.email});

  @override
  _TelaPinState createState() => _TelaPinState();
}

class _TelaPinState extends State<TelaPin> {
  String msg = 'Digite sua Senha:';
  var corMsg = Colors.black;
  TextEditingController pinController = TextEditingController();

  _entrar(BuildContext context) async {
    int pin = int.tryParse(pinController.text);
    //Loading
    if (pin == widget.pin) {
      var docUsuario = await Firestore.instance
          .collection('usuario')
          .document(widget.email)
          .get();

      String nomeUsuario = docUsuario['nome'];
      String emailUsuario = docUsuario['email'];
      List<Lista> listas = [];

      var docListas =
          await docUsuario.reference.collection('listas').getDocuments();

      for (var docLista in docListas.documents) {
        String idLista = docLista['id'];
        String nomeLista = docLista['nome'];
        DateTime dataLista = (docLista['data'] as Timestamp).toDate();
        List<Produto> produtos = [];

        var docProdutos =
            await docLista.reference.collection('produtos').getDocuments();

        for (var docProduto in docProdutos.documents) {
          String idProduto = docProduto['id'];
          String idCategoriaProduto = docProduto['idCategoria'];
          String nomeProduto = docProduto['nome'];
          bool isCompradoProduto = docProduto['isComprado'] as bool;
          produtos.add(Produto(
              id: idProduto,
              idCategoria: idCategoriaProduto,
              nome: nomeProduto,
              isComprado: isCompradoProduto));
        }
        listas.add(Lista(
            id: idLista, nome: nomeLista, data: dataLista, produtos: produtos));
      }

      widget.atualizarUsuario(
        Usuario(
          email: emailUsuario,
          nome: nomeUsuario,
          listasDeCompras: listas,
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', emailUsuario);
      Navigator.of(context).pop();
    } else {
      pinController.clear();
      setState(() {
        msg = 'Senha Incorreta.';
        corMsg = Colors.red;
        Future.delayed(Duration(seconds: 3), () {
          msg = 'Digite sua Senha:';
          corMsg = Colors.black;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      msg,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: corMsg),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLength: 4,
                      obscureText: true,
                      controller: pinController,
                      readOnly: true,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '1';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '2';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '3';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '4';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '4',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '5';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '5',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '6';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '6',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '7';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '7',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '8';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '8',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '9';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '9',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            pinController.text;
                            if (pinController.text.length >= 4) {
                              return;
                            }
                            String temp = pinController.text;
                            pinController.text = temp + '0';
                            if (pinController.text.length == 4) {
                              _entrar(context);
                            }
                          },
                          child: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
