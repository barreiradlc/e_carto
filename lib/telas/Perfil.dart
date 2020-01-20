import 'package:e_carto/Construtores/PerfilArguments.dart';
import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:http/http.dart' as http;
import 'package:e_carto/Funcoes/UserData.dart';

class Perfil extends StatefulWidget {
  Perfil({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PerfilState createState() => new _PerfilState();
}

class _PerfilState extends State<Perfil> {
  var profile;
  var botaoPerfil;
  var id;

  Future<String> getPerfil() async {
    void_getJWT().then((token) async {
      void_getID().then((id) async {
        print(token);

        print('aki');
        Dio dio = new Dio();
        // dio.options.headers['content-Type'] = 'application/json';
        dio.options.headers["authorization"] = token;
        // dio.options.headers["authorization"] = "token ${token}";
        var response = await dio.get(host + '/perfil');
        // print(response);
        print('response.data');
        print(response.data);
        print('response.data');

        setState(() {
          id = id;
          profile = response.data;
        });

        print('id');
        print(id);
        print(profile['id']);

        if (profile['id'] == id) {
          print('editar Perfil');
        }

        if (profile['id'] == id) {
          botaoPerfil = new FlatButton(
            onPressed: () {
              print('pokebola vai');
              Navigator.pushNamed(context, '/user/form',
                  arguments: PerfilArguments(
                    profile['name'],
                    profile['username'],
                    profile['email'],
                    profile['phone'],
                    profile['instagram'],
                    profile['pinterest'],
                    profile['about'],
                    profile['id'],
                    profile['avatar'],
                  ));
              print('pokebola foi');
            },
            child: new Container(
                child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.edit),
                new SizedBox(
                  width: MediaQuery.of(context).size.width / 30,
                ),
                new Text('EDITAR PERFIL')
              ],
            )),
            color: Colors.blue[50],
          );
        } else {
          botaoPerfil = new FlatButton(
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: AlertDialog(
                          content: Text('Funcionalidade a implementar')),
                    );
                  });
            },
            child: new Container(
                child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.person),
                new SizedBox(
                  width: MediaQuery.of(context).size.width / 30 / 30,
                ),
                new Text('SEGUIR')
              ],
            )),
            color: Colors.blue[50],
          );
        }
      });
    });

    return 'Sucesso';
  }

  @override
  void initState() {
    super.initState();
    var p = getPerfil();

    // print(p);
    print(profile);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // final String imgUrl = 'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';
    var imgUrl = 'assets/logo.png';

    var avatar;
    avatar = Image.asset(
      'assets/logo.png',
      fit: BoxFit.fitWidth,
    );

    if(profile['avatar']['url'] != null){
      avatar = Image.network(
        host + profile['avatar']['url']
      );
    }

    return profile != null
        ? new Stack(
            children: <Widget>[
              new Container(
                color: Colors.blue,
              ),
              avatar,
              new BackdropFilter(
                  filter: new ui.ImageFilter.blur(
                    sigmaX: 6.0,
                    sigmaY: 6.0,
                  ),
                  child: new Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.9),
                      // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  )),
              new Scaffold(
                  appBar: new AppBar(
                    title: new Text('Perfil'),
                    centerTitle: false,
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                  ),
                  // drawer: new Drawer(child: new Container(),),
                  backgroundColor: Colors.transparent,
                  body: new Center(
                    child: new Column(
                      children: <Widget>[
                        new SizedBox(
                          height: _height / 12,
                        ),
                        new CircleAvatar(
                          radius: _width < _height ? _width / 4 : _height / 4,
                          backgroundImage: 
                          profile['avatar']['url'] != null ?
                          NetworkImage(host + profile['avatar']['url'])
                          :
                          AssetImage(imgUrl),
                        ),
                        new SizedBox(
                          height: _height / 25.0,
                        ),
                        new Text(
                          profile['name'] != null ? profile['name'] : "",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 15,
                              color: Colors.white),
                        ),
                        new Text(
                          profile['username'] != null
                              ? profile['username']
                              : "",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 15,
                              color: Colors.white),
                        ),
                        new Text(
                          profile['email'] != null ? profile['email'] : "",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 35,
                              color: Colors.white),
                        ),
                        new Text(
                          profile['phone'] != null ? profile['phone'] : "",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 35,
                              color: Colors.white),
                        ),
                        new Text(
                          profile['instagram'] != null
                              ? profile['instagram']
                              : "",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 35,
                              color: Colors.white),
                        ),
                        new Text(
                          profile['pinterest'] != null
                              ? profile['pinterest']
                              : "",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 35,
                              color: Colors.white),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                              top: _height / 30,
                              left: _width / 8,
                              right: _width / 8),
                          child: new Text(
                            profile['pinterest'] != null
                                ? profile['pinterest']
                                : 'Se descreva em poucas palavras',
                            style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: _width / 25,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        new Divider(
                          height: _height / 30,
                          color: Colors.white,
                        ),

                        new Row(
                          children: <Widget>[
                            // Text(profile[1]),
                        //     rowCell(673826, 'FOLLOWERS'),
                        //     rowCell(275, 'FOLLOWING'),
                          ],),
                        new Divider(height: _height / 30, color: Colors.white),

                        new Padding(
                            padding: new EdgeInsets.only(
                                left: _width / 8, right: _width / 8),
                            child: botaoPerfil),
                      ],
                    ),
                  ))
            ],
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget rowCell(int count, String type) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(
            '$count',
            style: new TextStyle(color: Colors.white),
          ),
          new Text('a',
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  return null;
}
