import 'package:flutter/material.dart';

class ItemLista extends StatelessWidget {
  final String nome;
  final DateTime data;
  final Function onEditar;
  final Function onDeletar;
  ItemLista({this.nome, this.data, this.onDeletar, this.onEditar});

  String _formatarData(DateTime data) {
    String string = data.toString();
    String dia = string[8].toString() + string[9].toString();
    String mes = string[5].toString() + string[6].toString();
    String ano = string[0].toString() +
        string[1].toString() +
        string[2].toString() +
        string[3].toString();
    return dia + '/' + mes + '/' + ano;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            nome,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(_formatarData(data)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: onEditar,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDeletar,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
