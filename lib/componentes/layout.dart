import 'package:flutter/material.dart';

import 'container_layout.dart';

class Layout extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget child;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final BottomNavigationBar bottomNavigationBar;
  final Drawer drawer;

  Layout({
    this.title,
    this.child,
    this.actions,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        leading: drawer == null
            ? null
            : Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }),
              ),
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
