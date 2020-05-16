import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_navegacao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaSplash extends StatefulWidget {
  @override
  _TelaSplashState createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    super.initState();
    _isLogado().then((u) {
      Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaNavegacao(u),
          ),
        );
      });
    });
  }

  Future<Usuario> _isLogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    var conn = await Connectivity().checkConnectivity();
    if (email == null || email.isEmpty) {
      return null;
    } else {
      if (conn == ConnectivityResult.none) {
        var usuarioJS = prefs.getString('usuario');
        return Usuario.fromJson(json.decode(usuarioJS));
      } else {
        var doc = await Firestore.instance
            .collection('usuarios')
            .document(email)
            .get();
        return Usuario.fromJson(doc['dados']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_cart,
              size: MediaQuery.of(context).size.height * 0.20,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.25),
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
