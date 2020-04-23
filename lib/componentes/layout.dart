import 'package:flutter/material.dart';

import 'container_layout.dart';

class Layout extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget child;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final BottomNavigationBar bottomNavigationBar;

  Layout({
    this.title,
    this.child,
    this.actions,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(title),
        actions: actions,
      ),
      body: ContainerLayout(child: child),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation == null
          ? FloatingActionButtonLocation.endFloat
          : floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
