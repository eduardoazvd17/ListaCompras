import 'package:flutter/material.dart';
import 'package:listacompras/telas/tela_navegacao.dart';

class TelaSplash extends StatefulWidget {
  @override
  _TelaSplashState createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TelaNavegacao(null),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.shopping_cart,
          size: MediaQuery.of(context).size.height * 0.20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
