import 'package:flutter/material.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/utilitarios/validador.dart';

import 'form_ajustes_usuario.dart';

class DrawerUsuario extends StatelessWidget {
  final Usuario usuario;
  final Function atualizarUsuario;
  final Function retornarAoInicio;
  DrawerUsuario({
    this.usuario,
    this.atualizarUsuario,
    this.retornarAoInicio,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 200,
              color: Theme.of(context).primaryColor,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                  Text(
                    '${usuario.nome}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${usuario.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Alterar Nome'),
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                          ),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => FormAjustesUsuario(
                          atualizarUsuario: atualizarUsuario,
                          usuario: usuario,
                          opc: 0,
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.vpn_key),
                    title: Text('Alterar PIN'),
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                          ),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => FormAjustesUsuario(
                          atualizarUsuario: atualizarUsuario,
                          usuario: usuario,
                          opc: 1,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: Text('Finalizar Sessão'),
                onTap: () {
                  var v = Validador(context);
                  v.mostrarDialogoSN(
                    titulo: 'Finalizar Sesaão',
                    mensagem: 'Deseja realmente sair?',
                    sim: () {
                      retornarAoInicio();
                      atualizarUsuario(null);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    nao: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
