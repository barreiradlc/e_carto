import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class DetailScreen extends StatefulWidget {
  @override
  Details createState() => new Details();
}

class Details extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // var todo = ModalRoute.of(context).settings.arguments;
    final ScreenArguments item = ModalRoute.of(context).settings.arguments;

    @override
    void initState() {
      super.initState();
      print(item);
    }

    print(item);
    // Use the item to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(item.description),
      ),
    );
  }
}
