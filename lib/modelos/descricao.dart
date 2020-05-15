class Descricao {
  String descricao;
  double quantidade;
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
    this.quantidade = double.tryParse(json['quantidade'].toString());
    this.preco = json['preco'];
    this.prefixo = json['prefixo'];
  }
}
