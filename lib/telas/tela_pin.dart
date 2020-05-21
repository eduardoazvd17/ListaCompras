import 'package:flutter/material.dart';
import 'package:listacompras/componentes/botao_pin.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Widget _digitosPin(int d) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: d == 1 || d == 2 || d == 3 || d == 4
                ? Theme.of(context).primaryColor
                : Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: 15,
          height: 15,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: d == 2 || d == 3 || d == 4
                ? Theme.of(context).primaryColor
                : Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: 15,
          height: 15,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: d == 3 || d == 4
                ? Theme.of(context).primaryColor
                : Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: 15,
          height: 15,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: d == 4
                ? Theme.of(context).primaryColor
                : Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
      ],
    );
  }

  _entrar(BuildContext context) async {
    if (pinDigitado == widget.pin) {
      widget.atualizarUsuario(widget.usuario);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', widget.usuario.email);
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
                        pinDigitado.length == 0
                            ? _digitosPin(0)
                            : pinDigitado.length == 1
                                ? _digitosPin(1)
                                : pinDigitado.length == 2
                                    ? _digitosPin(2)
                                    : pinDigitado.length == 3
                                        ? _digitosPin(3)
                                        : _digitosPin(4),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
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
