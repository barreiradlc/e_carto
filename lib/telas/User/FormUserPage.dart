import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:e_carto/Construtores/PerfilArguments.dart';
import 'package:e_carto/Construtores/StepsConstructor.dart';

import 'package:e_carto/Funcoes/UserData.dart';
import 'package:e_carto/telas/Camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../Recursos/Api.dart';

class FormUserPage extends StatefulWidget {
  @override
  _FormUserPageState createState() => _FormUserPageState();
}

class _FormUserPageState extends State<FormUserPage> {
  bool isSwitched = true;

  var label = 'novo';
  var labelArte = 'Editar Perfil';
  var labelMaterial = 'Novo Material';

  File _image;

  var name = TextEditingController(text: '');
  var preco = TextEditingController(text: '0');
  var descricao = TextEditingController(text: '');

  var nome = TextEditingController(text: '');
  var usuario = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var telefone = TextEditingController(text: '');
  var instagram = TextEditingController(text: '');
  var pinterest = TextEditingController(text: '');
  var sobre = TextEditingController(text: '');

  String jwt;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageGal() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<String> req() async {
    Dio dio = new Dio();
    var response;
    var endpoint = '/perfil/edit';

    // print(jwt);

    FormData formData;
    formData = FormData.fromMap({
    //   'name': nome.text,
      'email': email.text,
    //   'phone': telefone.text,
    //   'instagram': instagram.text,
    //   'pinterest': pinterest.text,
    //   'about': sobre.text,
      
    //   // 'avatar': _image.path != null ? await MultipartFile.fromFile(_image.path,
    //   //     filename: nome.text + ".png"): null
    });





    // verifica se contém usuario
    if(usuario.text != ''){
      formData.fields.add(
        MapEntry(
          'username', usuario.text
        )
      );    
    }
    if(nome.text != ''){
      formData.fields.add(
        MapEntry(
          'name',nome.text
        )
      );
    }
    if(email.text != ''){
      formData.fields.add(
        MapEntry(
          'email',email.text
        )
      );
    }

    if(telefone.text != ''){
      formData.fields.add(
        MapEntry(
          'phone',telefone.text
        )
      );
    }
    if(instagram.text != ''){
      formData.fields.add(
        MapEntry(
          'instagram',instagram.text
        )
      );
    }
    if(pinterest.text != ''){
      formData.fields.add(
        MapEntry(
          'pinterest',pinterest.text
        )
      );
    }
    if(sobre.text != ''){
      formData.fields.add(
        MapEntry(
          'sobre',sobre.text
        )
      );
    }

    print(formData.fields);
    if(_image != null){
      print('tem foto');
      formData.files.add(
        MapEntry(
          'avatar', await MultipartFile.fromFile(_image.path,
            filename: nome.text + ".png")
        )
      );
    }




    print(formData.fields);

    // formData.files.addAll([
    //   MapEntry(
    //     'username': usuario.text != '' ? usuario.text : '';
    //   )
    // ]);






    response = await dio.put(
      host + endpoint,
      data: formData,
      options: Options(headers: {
        "Authorization": this.jwt,
        "Content-Type": "multipart/form-data"
      }),
    );
    print('formData');
    print(response.data);
    print(response);
    print('re sponse');
    print('response');
    var res = response.data;
    // var id = int.parse(res['id']);

    // print(id);

    if (res['id'] != null) {
      await Navigator.pushNamed(context, '/perfil');
    }

    // REQ


    // http.Response response = await http.post(Uri.encodeFull(url + endpoint),
    //     body: {
    //       'title': nome.text,
    //       'description': descricao.text,
    //       'avatar': _image
    //     });

    // print(response.body);
  }

  @override
  void initState() {
    super.initState();
    void_getJWT().then((jwt) {
      setState(() {
        this.jwt = jwt;
      });
      // this.getData();
    });
  }

  Widget build(BuildContext context) {
    final PerfilArguments item = ModalRoute.of(context).settings.arguments;
    final edge = 100;
    print(item.usuario);
    setState(() {
      nome.text = item.nome != null ? item.nome : '';
      usuario.text = item.usuario != null ? item.usuario : '';
      email.text = item.email != null ? item.email : '';
      telefone.text = item.telefone != null ? item.telefone : '';
      instagram.text = item.instagram != null ? item.instagram : '';
      pinterest.text = item.pinterest != null ? item.pinterest : '';
      sobre.text = item.sobre != null ? item.sobre : '';
    });

    return Theme(
        data: new ThemeData(
          primaryColor: isSwitched ? Colors.green : Colors.blue,
          // primaryColorDark: isSwitched ? Colors.green : Colors.blue,
        ),
        child: Scaffold(
            appBar: AppBar(
              title: Text(isSwitched ? labelArte : labelMaterial),
              backgroundColor: isSwitched ? Colors.green : Colors.blue,
            ),

            // primary: : isSwitched ? Colors.green : Colors.blue,
            // backgroundColor: isSwitched ? Colors.green : Colors.blue,
            body: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Form(
                      child: Column(mainAxisSize: MainAxisSize.max, children: <
                          Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                                color: isSwitched ? Colors.green : Colors.blue,
                                width: 2)),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                          // Text(
                          //   "Foto",
                          //   style: TextStyle(fontSize: 23),
                          // ),
                          _image == null
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      FlatButton(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 0),
                                          onPressed: getImage,
                                          child: Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2) -
                                                  edge,
                                              height: 200,
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.add_a_photo,
                                                        size: 22,
                                                      ),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ))),
                                      FlatButton(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          onPressed: getImageGal,
                                          child: Container(
                                              height: 200,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2) -
                                                  edge,
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .add_photo_alternate,
                                                        size: 22,
                                                      ),
                                                      Text(
                                                        'Galeria',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )))
                                    ],
                                  ))
                              : Image.file(
                                  _image,
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                        ])),
                    // Text(
                    //   "Foto",
                    //   style: TextStyle(fontSize: 23),
                    // ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                            
                            border: Border(bottom: BorderSide(
                                color: isSwitched ? Colors.green : Colors.blue,
                                width: 2))),
                      child: Text(
                        "Dados Pessoais",
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: nome,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Nome',
                          ),
                          autofocus: false,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: usuario,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Usuário',
                          ),
                          autofocus: false,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: email,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'E-mail',
                          ),
                          autofocus: false,
                        )),
                         Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 5,
                          controller: sobre,
                          // obscureText: true,
                          decoration: InputDecoration(
                            // fillColor: isSwitched ? Colors.green : Colors.blue,
                            filled: true,
                            focusColor: isSwitched ? Colors.green : Colors.blue,
                            // hoverColor: isSwitched ? Colors.green : Colors.blue,
                            // hoverColor: isSwitched ? Colors.green : Colors.blue,

                            // disabledBorder: InputBorder.none ,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            alignLabelWithHint: true,
                            labelText: 'Sobre mim',
                          ),
                          // autofocus: false,
                        )),
                        Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                            
                            border: Border(bottom: BorderSide(
                                color: isSwitched ? Colors.green : Colors.blue,
                                width: 2))),
                      child: Text(
                        "Dados de contato",
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: email,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Email',
                          ),
                          autofocus: false,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: telefone,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Telefone',
                          ),
                          autofocus: false,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: instagram,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Instagram',
                            prefixText: 'instagram.com/ ',

                          ),
                          autofocus: false,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          // cursorColor: isSwitched ? Colors.green : Colors.blue,
                          cursorColor: isSwitched ? Colors.green : Colors.blue,
                          controller: pinterest,
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Pinterest',
                            prefixText: 'pinterest.com/ ',
                          ),
                          autofocus: false,
                        )),
                   
                    // Container(
                    //     padding: EdgeInsets.symmetric(vertical: 20),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: <Widget>[
                    //         Text("Material",
                    //             style: TextStyle(
                    //                 color: isSwitched
                    //                     ? Colors.black38
                    //                     : Colors.blue)),
                    //         Switch(
                    //           value: isSwitched,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               isSwitched = value;
                    //             });
                    //           },
                    //           activeTrackColor: Colors.lightGreenAccent,
                    //           activeColor: Colors.green,
                    //           inactiveTrackColor: Colors.lightBlueAccent,
                    //           inactiveThumbColor: Colors.blue,
                    //         ),
                    //         Text(
                    //           "Arte",
                    //           style: TextStyle(
                    //               color: isSwitched
                    //                   ? Colors.green
                    //                   : Colors.black38),
                    //         ),
                    //       ],
                    //     )),
                    // Container(
                    //     padding: EdgeInsets.only(bottom: 10),
                    //     child: TextField(
                    //       // cursorColor: isSwitched ? Colors.green : Colors.blue,
                    //       cursorColor: isSwitched ? Colors.green : Colors.blue,
                    //       controller: preco,

                    //       // obscureText: true,
                    //       decoration: InputDecoration(
                    //         enabledBorder: const OutlineInputBorder(
                    //           borderSide: const BorderSide(color: Colors.grey),
                    //         ),
                    //         border: OutlineInputBorder(
                    //           borderRadius: const BorderRadius.all(
                    //             const Radius.circular(5.0),
                    //           ),
                    //         ),
                    //         labelText: 'Preço',
                    //         prefixText: 'R\$: ',
                    //       ),
                    //       // keyboardAppearance: ,
                    //       keyboardType: TextInputType.number,

                    //       autofocus: false,
                    //     )),
                    // Text("Adicionar imagem:"),

                    // alignment: Alignment(1.0, 1.0),
                    RaisedButton(
                        color: isSwitched ? Colors.green : Colors.blue,
                        padding: EdgeInsets.all(15),
                        onPressed: req,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Text(isSwitched ? labelArte : labelMaterial,
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ))
                  ])),
                ),
              ],
            )));
  }
}

class UploadFileInfo {}
