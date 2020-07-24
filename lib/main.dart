import 'package:flutter/material.dart';
import 'homepage.dart';
import 'dart:io';
import 'dart:async';
import 'functions.dart';
import 'package:flutter/foundation.dart';

import 'login.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _app createState() => _app();
}

class _app extends State<App> {
  var emp;
  var emp_name;

  get_emp() {
    localRead("emp_user").then((em) => {
          setState(() {
            print("emp username: $em");
            emp = em;
          })
        });
    localRead("emp_name").then((nam) => {
          setState(() {
            print("emp name: $nam");
            emp_name = nam;
          })
        });
  }

  void initState() {
    super.initState();
    get_emp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WellBE Employee',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: "San Fransisco",
        ),
        home: (emp != null ) ? HomePage(): LoginPage());
  }
}
