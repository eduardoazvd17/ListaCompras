class Descricao {
  String descricao;
  int quantidade;
  double preco;
  String prefixo;

  Descricao({
    this.descricao,
    this.quantidade,
    this.preco,
    this.prefixo,
  });

  Map<String, dynamic> toJson() {
    return {
      'descricao': this.descricao,
      'quantidade': this.quantidade,
      'preco': this.preco,
      'prefixo': this.prefixo,
    };
  }

  Descricao.fromJson(Map<String, dynamic> json) {
    this.descricao = json['descricao'];
    this.quantidade = json['quantidade'];
    this.preco = json['preco'];
    this.prefixo = json['prefixo'];
  }
}
