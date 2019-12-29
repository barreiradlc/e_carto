import 'package:flutter/material.dart';

void main() {
  runApp(Artes());
}

class Artes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final title = 'Grid List';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: title,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(title),
        // ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(5, (index) {
            var index2 = index + 1;
            return Center(
                child: Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(22.0),
                  child: Text(
                    'Arte $index2',
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ),
              floatingActionButton:
                  RaisedButton(onPressed: () {}, child: Text('Ver mais')),
            ));
          }),
        ),
      ),
    );
  }
}
