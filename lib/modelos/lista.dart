import 'package:listacompras/modelos/produto.dart';

class Lista {
  String id;
  String nome;
  DateTime data = DateTime.now();
  List<Produto> produtos;

  adicionarProduto(Produto p) {
    removerProduto(p);
    produtos.add(p);
  }

  removerProduto(Produto p) {
    produtos.removeWhere((pr) => pr.id == p.id);
  }

  Lista({this.id, this.nome, this.produtos});
}
