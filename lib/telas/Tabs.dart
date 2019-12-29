import 'package:flutter/material.dart';

import './Home/Wikis.dart';
import './Home/Materiais.dart';
import './Home/Artes.dart';

void main() {
  runApp(Tabs());
}

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: tabs(),
            automaticallyImplyLeading: false,
            // title: Text('Início'),
          ),
          body: TabBarView(
            children: [
              Wikis(),
              Artes(),
              Materiais(),
            ],
          ),
        ),
    );
  }
}

Widget tabs() {
  return TabBar(
    tabs: [
      Tab(icon: Icon(Icons.collections_bookmark), child: Text('Wikis')),
      Tab(icon: Icon(Icons.brush), child: Text('Artes')),
      Tab(icon: Icon(Icons.extension), child: Text('Materiais')),
    ],
  );
}
