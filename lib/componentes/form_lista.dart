import 'package:flutter/material.dart';

class FormLista extends StatefulWidget {
  @override
  _FormListaState createState() => _FormListaState();
}

class _FormListaState extends State<FormLista> {
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
                'Nova Lista',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.list),
                  hintText: "Insira um nome...",
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Data de criação: ${_formatarData(DateTime.now())}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Enviar',
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
    );
  }
}
