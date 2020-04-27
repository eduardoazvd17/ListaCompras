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
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlutterLogo(size: MediaQuery.of(context).size.width * 0.25),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Olá! Seja bem vindo!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Se já possui uma conta, insira seu e-mail no formulário abaixo.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Container(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              TextFormField(
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
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      String email =
                                          emailController.text.trim();

                                      if (email.isEmpty) {
                                        return;
                                      }

                                      if (!email.contains('@.')) {
                                        return;
                                      }

                                      int pin = int.tryParse('1234');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => TelaPin(
                                            email: email,
                                            atualizarUsuario: atualizarUsuario,
                                            pin: pin,
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
                              SizedBox(height: 10),
                              Row(
                                mainAxisSize: MainAxisSize.max,
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
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                    'Olá ${usuario.nome.split(' ').first}. Seja bem vindo!'),
              );
      },
    );
  }
}
