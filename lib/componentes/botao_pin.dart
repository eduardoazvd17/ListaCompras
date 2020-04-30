import 'package:flutter/material.dart';

class BotaoPin extends StatelessWidget {
  final int numero;
  final Function onTap;
  BotaoPin({this.numero, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: InkWell(
        onTap: () => onTap(context, numero),
        child: CircleAvatar(
          child: FittedBox(
            child: Text(
              numero.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
