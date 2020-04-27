import 'package:flutter/material.dart';
import 'package:listacompras/componentes/form_lista.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_inicio.dart';
import 'package:listacompras/telas/tela_listas.dart';

class TelaNavegacao extends StatefulWidget {
  final Usuario usuario;
  TelaNavegacao(this.usuario);
  @override
  _TelaNavegacaoState createState() => _TelaNavegacaoState(usuario);
}

class _TelaNavegacaoState extends State<TelaNavegacao> {
  Usuario usuario;
  int _itemSelecionado = 0;
  _TelaNavegacaoState(this.usuario);

  _atualizarUsuario(Usuario u) {
    setState(() {
      usuario = u;
    });
  }

  void _selecionarItem(int i) {
    setState(() {
      _itemSelecionado = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      TelaInicio(usuario: usuario, atualizarUsuario: _atualizarUsuario),
      TelaListas(usuario: usuario, atualizarUsuario: _atualizarUsuario),
    ];

    return Layout(
      title: usuario == null
          ? 'Entre com seu e-mail'
          : _itemSelecionado == 0 ? 'Inicio' : 'Listas de Compras',
      child: _telas[_itemSelecionado],
      actions: _itemSelecionado == 0
          ? <Widget>[
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    _atualizarUsuario(null);
                  })
            ]
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: usuario == null
          ? null
          : _itemSelecionado == 1
              ? FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => FormLista(
                          usuario: usuario,
                          atualizarUsuario: _atualizarUsuario),
                    );
                  },
                  child: Icon(Icons.add),
                )
              : null,
      bottomNavigationBar: usuario == null
          ? null
          : BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Inicio'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Listas de Compras'),
                ),
              ],
              currentIndex: _itemSelecionado,
              onTap: _selecionarItem,
            ),
    );
  }
}
