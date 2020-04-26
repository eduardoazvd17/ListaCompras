import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/modelos/lista.dart';
import 'package:listacompras/modelos/produto.dart';
import 'package:listacompras/modelos/usuario.dart';
import 'package:listacompras/telas/tela_navegacao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaSplash extends StatefulWidget {
  @override
  _TelaSplashState createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() async {
    super.initState();
    Usuario usuario;
    final prefs = await SharedPreferences.getInstance();
    String emailSalvo = prefs.getString('email');
    if (emailSalvo != null || emailSalvo.isNotEmpty) {
      var docUsuario = await Firestore.instance
          .collection('usuario')
          .document(emailSalvo)
          .get();

      String nomeUsuario = docUsuario['nome'];
      String emailUsuario = docUsuario['email'];
      List<Lista> listas = [];

      var docListas =
          await docUsuario.reference.collection('listas').getDocuments();

      for (var docLista in docListas.documents) {
        String idLista = docLista['id'];
        String nomeLista = docLista['nome'];
        DateTime dataLista = (docLista['data'] as Timestamp).toDate();
        List<Produto> produtos = [];

        var docProdutos =
            await docLista.reference.collection('produtos').getDocuments();

        for (var docProduto in docProdutos.documents) {
          String idProduto = docProduto['id'];
          String idCategoriaProduto = docProduto['idCategoria'];
          String nomeProduto = docProduto['nome'];
          bool isCompradoProduto = docProduto['isComprado'] as bool;
          produtos.add(Produto(
              id: idProduto,
              idCategoria: idCategoriaProduto,
              nome: nomeProduto,
              isComprado: isCompradoProduto));
        }
        listas.add(Lista(
            id: idLista, nome: nomeLista, data: dataLista, produtos: produtos));
        usuario = Usuario(
          email: emailUsuario,
          nome: nomeUsuario,
          listasDeCompras: listas,
        );
      }
      Future.delayed(
          Duration(
              seconds: emailSalvo != null || emailSalvo.isNotEmpty ? 1 : 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaNavegacao(usuario),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: MediaQuery.of(context).size.height * 0.25),
      ),
    );
  }
}
