import 'package:flutter/material.dart';
import 'package:listacompras/modelos/lista.dart';

class ItemLista extends StatelessWidget {
  final Lista lista;
  final Function onEditar;
  final Function onDeletar;
  final Function onTap;
  ItemLista({this.lista, this.onDeletar, this.onEditar, this.onTap});

  String _formatarData(String string) {
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
          onTap: () => onTap(lista, context),
          title: Text(
            lista.nome,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('Data: ' +
              _formatarData(lista.data) +
              '\nTotal: R\$${lista.calcularGastos().toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => onEditar(lista, context),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => onDeletar(lista, context),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
