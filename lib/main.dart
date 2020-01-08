
import 'package:e_carto/telas/DetailScreen.dart';
import 'package:e_carto/telas/EstoquePage.dart';
import 'package:e_carto/telas/Etapas.dart';
import 'package:e_carto/telas/NewWikiPage.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// telas
import './telas/Home.dart';
import './telas/Login.dart';
import './telas/Cadastro.dart';
// import  './telas/Camera.dart';
import 'package:e_carto/telas/Home/ExtractArgumentsScreen.dart';

import './Funcoes/UserData.dart';
import 'telas/DetailItemScreen.dart';
import 'telas/Itens/Form.dart';

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new Geral());
}

class Geral extends StatefulWidget {
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<Geral> {
  String jwt = '';
  String homePage = '';

  @override
  void initState() {
    super.initState();
    void_getJWT().then((jwt) {
      if (jwt == null) {
        homePage = '/login';
      } else {
        homePage = '/home';
      }
      print(jwt);
      setState(() {
        this.jwt = jwt;
        this.homePage = homePage;
        // this.username = username;
      });
    });
  }

  var inicio = new Home();
  var login = new Login();
  var cadastro = new Cadastro();
  var detalhes = new DetailScreen();
  var item = new DetailItemScreen();
  var estoque = new EstoquePage();
  
  var formItem = new FormItemPage();
  var formWiki = new FormWikiPage();
  var formSteps = new Etapas();
  // var tutorial = new Tutorial();
  // var camera = new Camera();

  @override
  Widget build(BuildContext context) {
    if (this.homePage != '') {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          // See https://github.com/flutter/flutter/wiki/Desktop-shells#fonts
          fontFamily: 'Roboto',
        ),
        initialRoute: this.homePage,
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/home': (context) => inicio,
          
          '/': (context) => login,
          '/cadastro': (context) => cadastro,
          // When navigating to the "/second" route, build the SecondScreen widget.
          
          '/details': (context) => detalhes,
          '/item': (context) => item,
          '/estoque': (context) => estoque,


          '/itens/form': (context) => formItem,

          '/wiki/form': (context) => formWiki,
          '/steps/form': (context) => formSteps,
          // '/camera': (context) => camera,
        },
        debugShowCheckedModeBanner: false,
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
