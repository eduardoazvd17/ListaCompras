import 'package:listacompras/modelos/lista.dart';

class Usuario {
  String nome;
  String email;
  List<Lista> listasDeCompras = [];

  Usuario({this.email, this.nome});

  adicionarLista(Lista l) {
    removerLista(l);
    listasDeCompras.add(l);
    listasDeCompras.sort(
      (a, b) => b.data.compareTo(a.data),
    );
  }

  removerLista(Lista l) {
    listasDeCompras.removeWhere((li) => li.id == l.id);
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
    return {
      'nome': this.nome,
      'email': this.email,
      'listasDeCompras': listas,
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
  }
}
