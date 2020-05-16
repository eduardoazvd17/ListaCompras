import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/validador.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormCadastro extends StatefulWidget {
  final Function atualizarUsuario;
  FormCadastro({this.atualizarUsuario});
  @override
  _FormCadastroState createState() => _FormCadastroState();
}

class _FormCadastroState extends State<FormCadastro> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController confirmacaoPinController = TextEditingController();

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
                  suffixIcon: Icon(Icons.person),
                  hintText: "Insira seu nome...",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail),
                  hintText: "Insira seu e-mail...",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 4,
                obscureText: true,
                controller: pinController,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.vpn_key),
                  hintText: "Insira seu pin...",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 4,
                obscureText: true,
                controller: confirmacaoPinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.vpn_key),
                  hintText: "Confirme seu pin...",
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var v = Validador(context);
                      String email = emailController.text.trim();
                      String nome = nomeController.text;
                      String pin = pinController.text;
                      String confirmacaoPin = confirmacaoPinController.text;

                      if (v.isVazio(email) ||
                          v.isVazio(nome) ||
                          v.isVazio(pin) ||
                          v.isVazio(confirmacaoPin)) {
                        return;
                      }

                      if (v.isEmail(email)) {
                        v.mostrarDialogoOK('E-mail Inválido',
                            'Digite um endereço de e-mail válido.');
                        return;
                      }

                      if (pin != confirmacaoPin) {
                        v.mostrarDialogoOK('Pins Diferentes',
                            'Os campos pin e confirmação dde pin devem ser iguais.');
                        return;
                      }

                      Usuario usuario = Usuario(nome: nome, email: email);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', usuario.email);

                      Firestore.instance
                          .collection('usuarios')
                          .document(usuario.email)
                          .setData({
                        'dados': usuario.toJson(),
                        'pin': pin.toString(),
                      });

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
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
