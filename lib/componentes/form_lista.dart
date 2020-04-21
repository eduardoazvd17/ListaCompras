import 'package:flutter/material.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/usuario.dart';

class FormLista extends StatefulWidget {
  final Usuario usuario;
  final Lista lista;
  final Function atualizarUsuario;
  FormLista({this.usuario, this.lista, this.atualizarUsuario});
  @override
  _FormListaState createState() => _FormListaState(lista == null
      ? TextEditingController()
      : TextEditingController(text: lista.nome));
}

class _FormListaState extends State<FormLista> {
  TextEditingController listaController;
  _FormListaState(this.listaController);

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
                widget.lista == null ? 'Nova Lista' : 'Editar Lista',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (string) {
                  if (string.isEmpty) {
                    return 'Insira um nome para a lista';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
                controller: listaController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.list),
                  hintText: "Insira um nome...",
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.lista == null
                    ? 'Data de criação: ${_formatarData(DateTime.now())}'
                    : 'Data de criação: ${_formatarData(widget.lista.data)}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      if (listaController.text.isEmpty) {
                        return;
                      }

                      Lista l;
                      if (widget.lista == null) {
                        //Cria
                        l = Lista(
                          id: (widget.usuario.listasDeCompras.length + 1)
                              .toString(),
                          nome: listaController.text,
                        );
                      } else {
                        //Edita
                        l = widget.lista;
                        l.nome = listaController.text;
                      }
                      widget.usuario.adicionarLista(l);
                      widget.atualizarUsuario(widget.usuario);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.lista == null ? 'Enviar' : 'Salvar',
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
