import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/validador.dart';

class FormAjustesUsuario extends StatefulWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final int opc;

  FormAjustesUsuario({
    this.atualizarUsuario,
    this.usuario,
    @required this.opc,
  });

  @override
  _FormAjustesUsuarioState createState() => opc == 0
      ? _FormAjustesUsuarioState(TextEditingController(text: usuario.nome))
      : _FormAjustesUsuarioState(TextEditingController());
}

class _FormAjustesUsuarioState extends State<FormAjustesUsuario> {
  final TextEditingController nomeController;
  final pinController = TextEditingController();
  final novoPinController = TextEditingController();
  final novoPinConfirmacaoController = TextEditingController();
  _FormAjustesUsuarioState(this.nomeController);

  _salvar() async {
    var v = Validador(context);
    if (widget.opc == 0) {
      String nome = nomeController.text;
      if (v.isVazio(nome)) {
        return;
      }
      widget.usuario.nome = nome;
      widget.atualizarUsuario(widget.usuario);
      Navigator.of(context).pop();
    } else {
      String pin = pinController.text;
      String novoPin = novoPinController.text;
      String confirmacaoNovoPin = novoPinConfirmacaoController.text;
      if (v.isVazio(pin) ||
          v.isVazio(novoPin) ||
          v.isVazio(confirmacaoNovoPin)) {
        return;
      }

      if (novoPin != confirmacaoNovoPin) {
        v.mostrarDialogoOK(
          'PINs Diferentes',
          'Os campos novo pin e confirmação de novo pin devem ser iguais.',
        );
        return;
      }

      v.mostrarCarregamento('Alterando PIN...');

      var docUser = await Firestore.instance
          .collection('usuarios')
          .document(widget.usuario.email)
          .get();

      if (pin != docUser['pin']) {
        v.ocultarCarregamento();
        v.mostrarDialogoOK(
          'PIN Incorreto',
          'O PIN atual está incorreto, verifique a digitação e tente novamente.',
        );
        return;
      }

      docUser.reference.updateData({'pin': novoPin});

      v.ocultarCarregamento();
      Navigator.of(context).pop();
    }
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
                widget.opc == 0 ? 'Alterar Nome' : 'Alterar PIN',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              SizedBox(height: 10),
              widget.opc == 0
                  ? Column(
                      children: <Widget>[
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: nomeController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            hintText: "Insira seu nome...",
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        TextFormField(
                          maxLength: 4,
                          obscureText: true,
                          controller: pinController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: false),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.vpn_key),
                            hintText: "Insira seu PIN atual...",
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          maxLength: 4,
                          obscureText: true,
                          controller: novoPinController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: false),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.vpn_key),
                            hintText: "Insira seu novo PIN...",
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          maxLength: 4,
                          obscureText: true,
                          controller: novoPinConfirmacaoController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.vpn_key),
                            hintText: "Confirme seu novo PIN...",
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(
                    onPressed: _salvar,
                    child: Text(
                      'Salvar',
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
