import 'package:e_carto/Construtores/WikisContructor.dart';
import 'package:e_carto/Parcial/MateriaisList.dart';
import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';

import '../main.dart';

import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  @override
  Details createState() => new Details();
}

class Details extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // var todo = ModalRoute.of(context).settings.arguments;
    final ScreenArguments item = ModalRoute.of(context).settings.arguments;
    String formatDate(DateTime date) =>
        new DateFormat("MMMM d").format(item.updated_at);
    String update = DateFormat('dd/MM/y kk:mm').format(item.updated_at);

    @override
    void initState() {
      super.initState();
      print(item);
    }

    var thumb;
    if (item.thumbnail == null) {
      thumb = Image.asset('assets/logo.png');
    } else {
      thumb = Image.network(host + item.thumbnail);
    }

    print(item.steps[0]);

    // Use the item to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
          padding: EdgeInsets.all(0),
          child: new ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  child: thumb
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(item.description), //
            ),
            MateriaisList(),
            RaisedButton(
              onPressed: () {
                showFancyCustomDialog(context);
              },
              child: Text("Show Simple Custom Dialog"),
            ),
            Container(
              alignment: Alignment(1.0, 1.0),
              padding: EdgeInsets.all(5),
              child: 
                Text("Última atualização em: " + update), //
            )
          ])),
    );
  }
    void showFancyCustomDialog(BuildContext context) {
        final ScreenArguments item = ModalRoute.of(context).settings.arguments;

        
        Dialog fancyDialog = Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            height: MediaQuery.of(context).size.height / 0.5,
            width: MediaQuery.of(context).size.width / 0.8,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Fancy Dialog Title!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Okay let's go!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
            // These values are based on trial & error method
                  alignment: Alignment(1.05, -1.05),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        showDialog(
            context: context, builder: (BuildContext context) => fancyDialog);
     }
}

//  NetworkImage(host + item.thumbnail)

