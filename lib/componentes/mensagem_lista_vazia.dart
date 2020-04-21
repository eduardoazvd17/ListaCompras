import 'package:flutter/material.dart';

class MensagemListaVazia extends StatelessWidget {
  final String mensagem;
  MensagemListaVazia(this.mensagem);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.shopping_cart,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
