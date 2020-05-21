import 'package:listacompras/modelos/informacoes.dart';

class Produto {
  String id;
  String idCategoria;
  String nome;
  bool isComprado = false;
  Informacoes informacoes;

  Produto({this.id, this.nome, this.idCategoria});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'idCategoria': this.idCategoria,
      'nome': this.nome,
      'isComprado': this.isComprado,
      'informacoes':
          this.informacoes == null ? null : this.informacoes.toJson(),
    };
  }

  Produto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.idCategoria = json['idCategoria'];
    this.nome = json['nome'];
    this.isComprado = json['isComprado'];
    if (json['informacoes'] != null) {
      this.informacoes = Informacoes.fromJson(json['informacoes']);
    }
  }
}
