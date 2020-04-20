import 'package:flutter/material.dart';

class ItemCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'categoria',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
