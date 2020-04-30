import 'package:flutter/material.dart';
import 'package:listacompras/componentes/botao_pin.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/modelos/usuario.dart';

class TelaPin extends StatefulWidget {
  final String pin;
  final Usuario usuario;
  final Function atualizarUsuario;
  TelaPin({this.atualizarUsuario, this.pin, this.usuario});

  @override
  _TelaPinState createState() => _TelaPinState();
}

class _TelaPinState extends State<TelaPin> {
  String msg = 'Digite sua Senha';
  Color corMsg;
  String pinDigitado = '';

  _entrar(BuildContext context) async {
    //Loading
    if (pinDigitado == widget.pin) {
      widget.atualizarUsuario(widget.usuario);
      Navigator.of(context).pop();
    } else {
      setState(() {
        msg = 'Senha Incorreta';
        corMsg = Colors.red;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          pinDigitado = '';
          msg = 'Digite sua Senha';
          corMsg = Theme.of(context).accentColor;
        });
      });
    }
  }

  _onTap(BuildContext context, int numero) {
    if (pinDigitado.length >= 4) {
      return;
    }
    String temp = pinDigitado;
    setState(() {
      pinDigitado = temp + numero.toString();
    });
    if (pinDigitado.length == 4) {
      _entrar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '',
      child: Center(
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
                          color: corMsg == null
                              ? Theme.of(context).accentColor
                              : corMsg),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        Text(
                          pinDigitado.length == 0
                              ? "_ _ _ _"
                              : pinDigitado.length == 1
                                  ? "* _ _ _"
                                  : pinDigitado.length == 2
                                      ? "* * _ _"
                                      : pinDigitado.length == 3
                                          ? "* * * _"
                                          : "* * * *",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        BotaoPin(
                          numero: 1,
                          onTap: _onTap,
                        ),
                        BotaoPin(
                          numero: 2,
                          onTap: _onTap,
                        ),
                        BotaoPin(
                          numero: 3,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        BotaoPin(
                          numero: 4,
                          onTap: _onTap,
                        ),
                        BotaoPin(
                          numero: 5,
                          onTap: _onTap,
                        ),
                        BotaoPin(
                          numero: 6,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        BotaoPin(
                          numero: 7,
                          onTap: _onTap,
                        ),
                        BotaoPin(
                          numero: 8,
                          onTap: _onTap,
                        ),
                        BotaoPin(
                          numero: 9,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        BotaoPin(
                          numero: 0,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    pinDigitado.length == 0
                        ? FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          )
                        : FlatButton(
                            onPressed: () {
                              if (msg == 'Senha Incorreta') {
                                return;
                              }
                              setState(() {
                                pinDigitado = pinDigitado.substring(
                                    0, pinDigitado.length - 1);
                              });
                            },
                            child: Text(
                              'Apagar',
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
