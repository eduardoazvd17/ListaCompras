import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/modelos/usuario.dart';

class FormCadastro extends StatefulWidget {
  final Function atualizarUsuario;
  FormCadastro({this.atualizarUsuario});
  @override
  _FormCadastroState createState() => _FormCadastroState();
}

class _FormCadastroState extends State<FormCadastro> {
  TextEditingController emailController;
  TextEditingController nomeController;
  TextEditingController pinController;
  TextEditingController confirmacaoPinController;

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
                'Efetuar Cadastro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: nomeController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.list),
                  hintText: "Insira seu nome...",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail),
                  hintText: "Insira seu e-mail...",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 4,
                controller: pinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.vpn_key),
                  hintText: "Insira seu pin...",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 4,
                controller: confirmacaoPinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.vpn_key),
                  hintText: "Confirmação de pin...",
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      String email = emailController.text.trim();
                      String nome = nomeController.text;
                      int pin = int.tryParse(pinController.text);
                      int confirmacaoPin =
                          int.tryParse(confirmacaoPinController.text);

                      if (email.isEmpty ||
                          nome.isEmpty ||
                          pin == null ||
                          confirmacaoPin == null) {
                        return;
                      }

                      if (!email.contains('@.')) {
                        return;
                      }

                      if (pin != confirmacaoPin) {
                        return;
                      }

                      Usuario usuario = Usuario(nome: nome, email: email);
                      Firestore.instance
                          .collection('usuarios')
                          .document(email)
                          .setData({
                        'nome': nome,
                        'email': email,
                      });
                      Firestore.instance
                          .collection('pins')
                          .document(email)
                          .setData(
                        {
                          'pin': pin,
                        },
                      );
                      widget.atualizarUsuario(usuario);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Enviar',
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
    );
  }
}
