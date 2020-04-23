import 'package:listacompras/modelos/lista.dart';

class Usuario {
  String email;
  List<Lista> listasDeCompras = [];

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

  Usuario({this.email});
}
