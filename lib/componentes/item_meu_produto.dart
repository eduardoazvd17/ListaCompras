import 'package:flutter/material.dart';

class ItemMeuProduto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'meu produto',
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_comment,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
