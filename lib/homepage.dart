import 'package:flutter/material.dart';
import 'drawer.dart';

class HomePage extends StatelessWidget {
  // final mobile_no = fillMobileNumber();
  // var mobile_no = fillMobileNumber();
  // var a = trylocalwrite();
  // String user;
  void main() {
    new SnackBar(
      duration: new Duration(seconds: 2),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text("   Signing In...")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WellBE Employee"),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.network(
                      "https://img.icons8.com/cotton/68/000000/person-male--v2.png"),
                  Column(
                    children: <Widget>[
                      Text(
                        '<name>',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
