import 'package:flutter/material.dart';

class ContainerLayout extends StatelessWidget {
  final Widget child;
  ContainerLayout({this.child});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: child == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: child,
                  ),
          ),
        );
      },
    );
  }
}
