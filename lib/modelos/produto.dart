class Produto {
  String id;
  String idCategoria;
  String nome;
  bool isComprado = false;

  Produto({this.id, this.nome, this.idCategoria});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'idCategoria': this.idCategoria,
      'nome': this.nome,
      'isComprado': this.isComprado,
    };
  }

  Produto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.idCategoria = json['idCategoria'];
    this.nome = json['nome'];
    this.isComprado = json['isComprado'];
  }
}
