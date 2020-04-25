import 'package:flutter/material.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_navegacao.dart';

class TelaSplash extends StatefulWidget {
  @override
  _TelaSplashState createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    super.initState();
    Usuario usuario = Usuario(email: 'admin@eduardoazevedo.dev');
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TelaNavegacao(usuario),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: MediaQuery.of(context).size.height * 0.25),
      ),
    );
  }
}
