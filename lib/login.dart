import 'package:flutter/material.dart';
import 'package:wellbeEmp/homepage.dart';
import 'homepage.dart';
import 'functions.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'drawer.dart';
import 'emp_forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<void> logoutEmployee() async {
  String _user = await storage.read(key: "emp_user");
  String _token = await storage.read(key: "emp_token");
  print(_user);
  print(_token);
  final uri = 'https://ew4cfeyx74.execute-api.us-east-1.amazonaws.com/test';
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {"user_name": _user, "token": _token};
  Response response = await post(
    uri,
    headers: headers,
    body: jsonEncode(body),
  );
  var resp = jsonDecode(response.body);
  print(resp);
  if (resp["statusCode"] == 200) {
    localDelete("emp_user");
    localDelete("emp_name");
    localDelete("emp_token");
  }
}

class _LoginPageState extends State<LoginPage> {
  // bool _obscureText = true;

  // void togglePassword(){
  // 	setState(() {
  // 	  _obscureText = !_obscureText;
  // 	});
  // }

  String user_name = "";
  String password = "";
  bool error = false;
  String error_msg = "";
  TextEditingController _userNameChannge = TextEditingController();
  TextEditingController _passWordChannge = TextEditingController();

  void _submit() {
    setState(() {
      user_name = _userNameChannge.text;
      password = _passWordChannge.text;
    });
  }

  Future<void> _LoginEmployee(String _username, String _password) async {
    final uri = 'https://338olfndp4.execute-api.us-east-1.amazonaws.com/test';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"user_name": _username, "password": _password};
    print(body);
    Response response = await post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    var resp = jsonDecode(response.body);
    print(resp);
    int responseBody = resp["status"];
    // int responseBody = 1;
    if (responseBody == 1) {
      String _token = resp["sess_token"];
      String _name = resp["name"];
      // String _name = "Raja";
      print("login successful");
      print(_token);
      // String _token = "WeLc4qHz3xZtoHggl_P9zzM7cv6osGk2cTrjz3gUTrU";
      localWrite("emp_name", _name);
      localWrite("emp_user", _username);
      localWrite("emp_token", _token);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Login Sucess"),
              content: new Text("Your login is successful."),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => HomePage()));
                    },
                    child: new Text("Close"))
              ],
            );
          });
    } else if (responseBody == 0) {
      print("incorrect password");
      setState(() {
        error = true;
        error_msg = "Invalid username or password";
      });
    } else if (responseBody == -1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("In Active user"),
              content: new Text(
                  "Your account isn't yet verified. Please visit nearby office for verification."),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => HomePage()));
                    },
                    child: new Text("Close"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("WellBE"),
      // ),
      // drawer: AppDrawer(),
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 60.0),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                  Column(crossAxisAlignment: CrossAxisAlignment.start ,children: <Widget>[
                    Text(
                      "Welcome to",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.white,
                      ),
                    ),
                    Text(
                      "WellBe",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 46, fontWeight: FontWeight.bold
                          // color: Colors.white,
                          ),
                    ),
                  ]),
                  Image(image: AssetImage('assets/images/logo_size_android.jpg')),
                ]),
                SizedBox(height: 40.0,),
                Text(
									"Log In",
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 24,
										// color: Colors.white,
									),
								),
                SizedBox(height: 20.0),
                Text(
                  "Login with the credentails sent to you by WellBe team. Plese keep your credentials confidential.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontSize: 20,
                    // color: Colors.white,
                  ),
                ),
                SizedBox(height: 40.0),
                error
                    ? new SizedBox(
                        height: 40.0,
                        child: Text(
                          error_msg,
                          style: TextStyle(color: Colors.grey),
                        ))
                    : new SizedBox(height: 1.0),
                new TextFormField(
                  // style: TextStyle(color: Colors.white),
                  controller: _userNameChannge,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty User Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "User Name",
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    errorStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _passWordChannge,
                  // style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Password",
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    errorStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
                new FlatButton(
                  child: Text(
                    "Forgot password?",
                    // style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => EmpForgotPass()));
                  },
                ),
                new ButtonBar(
                  children: <Widget>[
                    new RaisedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          user_name = _userNameChannge.text;
                          password = _passWordChannge.text;
                        });
                        (_formKey.currentState.validate())
                            ? _LoginEmployee(user_name, password)
                            : null;
                            
                      },
                      // borderSide: BorderSide(color: Colors.white),
                      // shape: StadiumBorder(),
                      color: Colors.blue
                    )
                  ],
                  alignment: MainAxisAlignment.center,
                )
              ],
            ),
            // width: 250.0,
            // margin: EdgeInsets.only(left: 48),
          ),
          autovalidate: true,
        ),
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topRight,
        //         end: Alignment.bottomLeft,
        //         colors: [Colors.blue, Colors.teal])),
      ),
    );
  }
}
