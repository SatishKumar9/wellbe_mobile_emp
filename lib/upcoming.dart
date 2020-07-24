import 'package:flutter/material.dart';
import 'drawer.dart';
import 'functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'homepage.dart';


class upcomingCamps extends StatefulWidget {
  @override
  _upcomingCampsState createState() => _upcomingCampsState();
}

class _upcomingCampsState extends State<upcomingCamps> {

  
  String u_name;
  var respdata;
  var camp_data;
  var finished = [];
  var upcoming = [];
  
  // void main() {
  //   new SnackBar(
  //     duration: new Duration(seconds: 2),
  //     content: new Row(
  //       children: <Widget>[
  //         new CircularProgressIndicator(),
  //         new Text("   Signing In...")
  //       ],
  //     ),
  //   );
  // }

   @override
  void initState(){
    super.initState();
    getUser();
  }

  void getUser() async {
    localRead("emp_user").then((user) => {
        setState((){
          u_name = user;
          }),
          get_camps(u_name)
        });
  }

  get_camps(String u_name) async{

    

    final Map<String,dynamic> CampData={
      "user_name" : u_name
    };
    print("xheck: $u_name ");

    http.post(
      'https://ktwugdu1g6.execute-api.us-east-1.amazonaws.com/employeecampview',
      headers:{'Content-Type':'application/json'},
      body:json.encode(CampData)).then((http.Response resp){
      setState(() {
                        respdata = json.decode(resp.body);
                      });
                      camp_data = respdata['response'];
                      DateTime now = DateTime.now();
                      print(now);
                      for(var i=0;i<camp_data.length;i++){
                        String p =  camp_data[i]["date"]+" "+ camp_data[i]["time"];

                        if(now.isAfter(DateTime.parse(p))){
                          finished.add(camp_data[i]);
                        }
                        else{
                          upcoming.add(camp_data[i]);
                        }
                      }
              });
                      
                                        }


  @override
  Widget build(BuildContext context) {
    return (camp_data!=null)
      ?Container(
        child: Form(
          //key: _formKey,---------------------------------------------
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: upcoming.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    shadowColor: Colors.black,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                    
                            title:
                              Text("Camp name: ${upcoming[index]["campname"]}"),                               
                            subtitle: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height:10.0),
                                Text("${upcoming[index]["campname"]} will be organised by ${upcoming[index]["orgname"]}")
                              ],
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 10.0, top: 10.0, right: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Date: ${upcoming[index]["date"]} "),
                              RaisedButton(
                                child: Text(
                                  "Upcoming",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => {
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()))
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
      )
      :Column(
        children:<Widget>[
          Center(
            heightFactor: 15,
            child:CircularProgressIndicator()
          )
        ],
      
    );
  }
}
