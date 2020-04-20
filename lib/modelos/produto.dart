import 'package:listacompras/modelos/categoria.dart';

class Produto {
  String id;
  Categoria categoria;
  String nome;

  Produto({this.id, this.nome, this.categoria});
}
