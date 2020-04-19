import 'package:flutter/material.dart';
import 'package:listacompras/componentes/layout.dart';
import 'package:listacompras/telas/tela_configuracoes.dart';
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
      TelaConfiguracoes(),
    ];

    return Layout(
      title: _itemSelecionado == 0
          ? 'Inicio'
          : _itemSelecionado == 1 ? 'Listas de Compras' : 'Configurações',
      child: _telas[_itemSelecionado],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Listas de Compras'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Configurações'),
          ),
        ],
        currentIndex: _itemSelecionado,
        onTap: _selecionarItem,
      ),
    );
  }
}
