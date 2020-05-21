import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';

class Usuario {
  String nome;
  String email;
  List<Lista> listasDeCompras = [];
  List<Produto> produtosPersonalizados = [];

  Usuario({this.email, this.nome});

  adicionarLista(Lista l) {
    removerLista(l);
    listasDeCompras.add(l);
    listasDeCompras.sort(
      (a, b) => b.data.compareTo(a.data),
    );
  }

  adicionarProdutoPersonalizado(Produto p) {
    p.informacoes = null; //Remove as informações adicionais
    removerProdutoPersonalizado(p);
    produtosPersonalizados.add(p);
    produtosPersonalizados.sort(
      (a, b) => a.nome.compareTo(b.nome),
    );
  }

  removerLista(Lista l) {
    listasDeCompras.removeWhere((li) => li.id == l.id);
  }

  removerProdutoPersonalizado(Produto p) {
    produtosPersonalizados.removeWhere((pr) => pr.id == p.id);
  }

  Lista listaPorId(String id) {
    for (var l in listasDeCompras) {
      if (l.id == id) {
        return l;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> listas = [];
    for (var l in listasDeCompras) {
      listas.add(l.toJson());
    }
    List<Map<String, dynamic>> pPersonalizados = [];
    for (var p in produtosPersonalizados) {
      pPersonalizados.add(p.toJson());
    }
    return {
      'nome': this.nome,
      'email': this.email,
      'listasDeCompras': listas,
      'produtosPersonalizados': pPersonalizados,
    };
  }

  Usuario.fromJson(Map<String, dynamic> json) {
    this.nome = json['nome'];
    this.email = json['email'];
    List<Lista> listas = [];
    for (var l in json['listasDeCompras']) {
      listas.add(Lista.fromJson(l));
    }
    this.listasDeCompras = listas;
    List<Produto> pPersonalizados = [];
    for (var p in json['produtosPersonalizados']) {
      pPersonalizados.add(Produto.fromJson(p));
    }
    this.produtosPersonalizados = pPersonalizados;
  }
}
