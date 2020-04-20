import 'package:flutter/material.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/telas/tela_inicio.dart';
import 'package:listacompras/telas/tela_listas.dart';

class TelaNavegacao extends StatefulWidget {
  @override
  _TelaNavegacaoState createState() => _TelaNavegacaoState();
}

class _TelaNavegacaoState extends State<TelaNavegacao> {
  int _itemSelecionado = 0;

  void _selecionarItem(int i) {
    setState(() {
      _itemSelecionado = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      TelaInicio(),
      TelaListas(),
    ];

    return Layout(
      title: _itemSelecionado == 0 ? 'Inicio' : 'Listas de Compras',
      child: _telas[_itemSelecionado],
      floatingActionButton: _itemSelecionado == 1
          ? FloatingActionButton(
              onPressed: () {},
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
