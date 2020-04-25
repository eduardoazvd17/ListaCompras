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
  Function atualizarUsuario;
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
      TelaInicio(),
      TelaListas(usuario: usuario, atualizarUsuario: _atualizarUsuario),
    ];

    return Layout(
      title: _itemSelecionado == 0 ? 'Inicio' : 'Listas de Compras',
      child: _telas[_itemSelecionado],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _itemSelecionado == 1
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
                      usuario: usuario, atualizarUsuario: _atualizarUsuario),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
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
