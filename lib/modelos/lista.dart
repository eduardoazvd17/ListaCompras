import 'dart:collection';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/utilitarios/dados.dart';

class Lista {
  String id;
  String nome;
  String data = DateTime.now().toString();
  List<Produto> produtos = [];

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> produtosJson = [];
    for (var p in produtos) {
      produtosJson.add(p.toJson());
    }
    return {
      'id': this.id,
      'nome': this.nome,
      'data': this.data,
      'produtos': produtosJson,
    };
  }

  double calcularGastos() {
    double total = 0;
    for (var p in produtos) {
      if (p.informacoes != null) {
        if (p.informacoes.quantidade != null && p.informacoes.preco != null) {
          total += (p.informacoes.quantidade * p.informacoes.preco);
        }
      }
    }
    return total;
  }

  Lista.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.nome = json['nome'];
    this.data = json['data'];
    List<Produto> listaProdutos = [];
    for (var p in json['produtos']) {
      listaProdutos.add(Produto.fromJson(p));
    }
    this.produtos = listaProdutos;
  }

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
