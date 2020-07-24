import 'package:flutter/material.dart';
import 'package:wellbeEmp/homepage.dart';
import 'main.dart';
import 'functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'drawer.dart';

class UserRequestFund extends StatefulWidget {
  @override
  _UserRequestFundState createState() => _UserRequestFundState();
}

class _UserRequestFundState extends State<UserRequestFund> {
  String data;
  var superheros_length;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  accept_request(id, phone_no) async {
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "donation_id": "$id",
      "phone_no": "$phone_no",
      "accept": 1
    };
    http.Response response = await http.post(
        "https://dxee4k3fg3.execute-api.us-east-1.amazonaws.com/test",
        headers: headers,
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      data = response.body;
      print(data);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Accepted Request"),
              content: new Text(
                  "The rewarded money will be deposited in your account. It is your reponsibility to help them."),
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
    } else {
      print(response.statusCode);
    }
  }

  reject_request(id, phone_no) async {
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "donation_id": "$id",
      "phone_no": "$phone_no",
      "accept": 0
    };
    http.Response response = await http.post(
        "https://dxee4k3fg3.execute-api.us-east-1.amazonaws.com/test",
        headers: headers,
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      data = response.body;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Rejected Post"),
              content: new Text(
                  "Successfully deleted request from database and the response is recorded"),
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
    } else {
      print(response.statusCode);
    }
  }

  proceedRequest(id, phone_no) {
    print("$id, $phone_no");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Confirm Proceed"),
            content: new Text(
                "Only after you have verified all the necessary documents, click 'Accept' to proceed further. If you find something is malicious, click 'Reject'."),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    accept_request(id, phone_no);
                  },
                  child: new Text("Accept")),
              new FlatButton(
                  onPressed: () {
                    reject_request(id, phone_no);
                  },
                  child: new Text("Reject"))
            ],
          );
        });
  }

  void getData(username) async {
    final headers = {'Content-Type': 'application/json'};
    print(username);
    Map<String, dynamic> body = {"username": "$username"};
    http.Response response = await http.post(
        "https://kaabe3cvh5.execute-api.us-east-1.amazonaws.com/test",
        headers: headers,
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      data = response.body;
      print(data);
      setState(() {
        superheros_length = jsonDecode(data)['body'];
        print(superheros_length.length);
      });
    } else {
      print(response.statusCode);
    }
  }

  void getUser() async {
    localRead("emp_user").then((user) => {
          (user != null)
              ? getData(user)
              : Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => HomePage()))
        });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("FundRaiser Requests"),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount:
                  superheros_length == null ? 0 : superheros_length.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    shadowColor: Colors.black,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            // leading: Image.network(
                            //   jsonDecode(data)['data'][index]['url'],
                            //   fit: BoxFit.fill,
                            //   width: 100,
                            //   height: 500,
                            //   alignment: Alignment.center,
                            // ),
                            title:
                                Text(jsonDecode(data)['body'][index]['name']),
                            subtitle: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height:10.0),
                                Text(jsonDecode(data)['body'][index]['reason']),
                                SizedBox(height:5.0),
                                Text(jsonDecode(data)['body'][index]
                                    ['description'])
                              ],
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 10.0, top: 10.0, right: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(jsonDecode(data)['body'][index]["phone_no"]
                                  .toString()),
                              RaisedButton(
                                child: Text(
                                  "Proceed",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => {
                                  proceedRequest(
                                      jsonDecode(data)['body'][index]
                                          ["donation_id"],
                                      jsonDecode(data)['body'][index]
                                          ["phone_no"])
                                },
                                color: Colors.deepPurple,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // width: 250.0,
            // margin: EdgeInsets.only(left: 48),
          ),
          autovalidate: true,
        ),
      ),
    );
  }
}
