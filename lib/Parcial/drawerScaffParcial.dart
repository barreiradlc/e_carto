import 'package:e_carto/Funcoes/UserData.dart';
import 'package:flutter/material.dart';

class Drawer extends StatefulWidget {
  @override
  DrawerState createState() => new DrawerState();
}

class DrawerState extends State<Drawer> {

@override
  Widget build(BuildContext context) {

  @override
    void initState() {
      // _getJWT();
      super.initState();
      // Add listeners to this class
      getUser().then((username) {
        print(username);
        setState(() {
          username = username;
        });
      });
    }

  var drawerScaff = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Bem Vindo " + this.username),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: bg,
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
              ),
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          ListTile(
            title: Text('Estoque'),
            onTap: () {
              Navigator.pushNamed(context, '/estoque');
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
    );

    return null;
  }
}