import 'package:flutter/material.dart';

class TelaConfiguracoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Text('Configs'),
        );
      },
    );
  }
}
