import 'package:listacompras/modelos/lista.dart';

class Usuario {
  String email;
  List<Lista> listasDeCompras = [];

  adicionarLista(Lista l) {
    removerLista(l);
    listasDeCompras.add(l);
  }

  removerLista(Lista l) {
    listasDeCompras.removeWhere((li) => li.id == l.id);
  }

  Usuario({this.email});
}
