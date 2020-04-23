import 'dart:collection';

import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/utilitarios/dados.dart';

class Lista {
  String id;
  String nome;
  DateTime data = DateTime.now();
  List<Produto> produtos = [];

  adicionarProduto(Produto p) {
    removerProduto(p);
    produtos.add(p);
    produtos.sort(
      (a, b) => a.nome.toLowerCase().compareTo(
            b.nome.toLowerCase(),
          ),
    );
  }

  removerProduto(Produto p) {
    produtos.removeWhere((pr) => pr.id == p.id);
  }

  Map<String, List<Produto>> produtosPorCategoria() {
    Map<String, List<Produto>> produtosPorCategoria = new HashMap();
    for (var c in Dados().categorias) {
      List<Produto> ps = produtos.where((p) => p.idCategoria == c.id).toList();
      ps.sort(
        (a, b) => a.nome.toLowerCase().compareTo(
              b.nome.toLowerCase(),
            ),
      );
      produtosPorCategoria.putIfAbsent(c.id, () => ps);
    }
    return produtosPorCategoria;
  }

  bool verificarExistencia(Produto p) {
    for (var pr in produtos) {
      if (pr.id == p.id) {
        return true;
      }
    }
    return false;
  }

  Lista({this.id, this.nome});
}
