import 'package:listacompras/modelos/produto.dart';

class ProdutoPersonalizado {
  String id;
  String idCategoria;
  String nome;

  ProdutoPersonalizado({this.id, this.nome, this.idCategoria});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'idCategoria': this.idCategoria,
      'nome': this.nome,
    };
  }

  ProdutoPersonalizado.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.idCategoria = json['idCategoria'];
    this.nome = json['nome'];
  }

  ProdutoPersonalizado.fromProduto(Produto p) {
    this.id = p.id;
    this.idCategoria = p.idCategoria;
    this.nome = p.nome;
  }
}
