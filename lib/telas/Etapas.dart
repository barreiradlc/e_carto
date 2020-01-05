import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_carto/Construtores/StepsConstructor.dart';
import 'package:e_carto/telas/Passo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Etapas extends StatefulWidget {
  // final steps;
  // Etapas(this.steps);

  @override
  EtapaState createState() => new EtapaState();
}

class EtapaState extends State<Etapas> {
  File _image;
  String uri = 'https://ae-teste.herokuapp.com';
  
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



  Widget build(BuildContext context) {
      final StepsArguments item = ModalRoute.of(context).settings.arguments;

      print('------');
      print('------');
      print(item);
      print('------');
      print('------');

    //   var etapas = CarouselSlider(
    //   height: double.infinity,
      
    //   // aspectRatio: 16 / 9,
    //   // viewportFraction: 0.8,
    //   // initialPage: 0,
    //   enableInfiniteScroll: false,
    //   // reverse: false,
    //   autoPlay: false,
    //   // autoPlayInterval: Duration(seconds: 3),
    //   // autoPlayAnimationDuration: Duration(milliseconds: 800),
    //   //  autoPlayCurve: Curve.fastOutSlowIn,
    //   // pauseAutoPlayOnTouch: Duration(seconds: 10),
    //   enlargeCenterPage: true,
    //   //  onPageChanged: callbackFunction,
    //   scrollDirection: Axis.horizontal,

    //   items: widget.item.map<Widget>((i, index) {

    //     return Builder(
    //       builder: (BuildContext context) {
    //         if(i[index] == null){
    //           return Passo(i[index], 'editar');
    //         }
    //           return Passo(i[index], 'criar');
    //       },
    //     );
        
    //   }).toList(),

    // );
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Passo"),
      ),
      body: Column(
        children: <Widget>[
          // etapas,
        ],
      )
    );

  }



}
