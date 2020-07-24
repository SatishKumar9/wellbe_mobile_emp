import 'package:flutter/material.dart';
import 'package:wellbeEmp/finished.dart';
import 'package:wellbeEmp/upcoming.dart';
import 'drawer.dart';
import 'functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // String u_name;
  // var respdata;
  // var camp_data;
  // var finished = [];
  // var upcoming = [];
  
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

  //  @override
  // void initState(){
  //   super.initState();
  //   getUser();
  // }

  // void getUser() async {
  //   localRead("emp_user").then((user) => {
  //       setState((){
  //         u_name = user;
  //         }),
  //         get_camps(u_name)
  //       });
  // }

  // get_camps(String u_name) async{

    

  //   final Map<String,dynamic> CampData={
  //     "user_name" : u_name
  //   };
  //   print("xheck: $u_name ");

  //   http.post(
  //     'https://ktwugdu1g6.execute-api.us-east-1.amazonaws.com/employeecampview',
  //     headers:{'Content-Type':'application/json'},
  //     body:json.encode(CampData)).then((http.Response resp){
  //     setState(() {
  //                       respdata = json.decode(resp.body);
  //                     });
  //                     camp_data = respdata['response'];
  //                     DateTime now = DateTime.now();
  //                     print(now);
  //                     for(var i=0;i<camp_data.length;i++){
  //                       String p =  camp_data[i]["date"]+" "+ camp_data[i]["time"];

  //                       if(now.isAfter(DateTime.parse(p))){
  //                         finished.add(camp_data[i]);
  //                       }
  //                       else{
  //                         upcoming.add(camp_data[i]);
  //                       }
  //                     }
  //             });
                      
  //                                       }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("WellBE Employee"),
    //   ),
    //   drawer: AppDrawer(),
    //   body: 
    //   (camp_data!=null)
    //   ?Container(
    //     child: Form(
    //       //key: _formKey,---------------------------------------------
    //       child: Container(
    //         padding: EdgeInsets.all(20.0),
    //         child: ListView.builder(
    //           itemCount: camp_data.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return Container(
    //               padding: EdgeInsets.symmetric(vertical: 10.0),
    //               child: Card(
    //                 shadowColor: Colors.black,
    //                 child: Container(
    //                   child: Column(
    //                     children: <Widget>[
    //                       ListTile(
                    
    //                         title:
    //                           Text("Camp name: ${camp_data[index]["campname"]}"),                               
    //                         subtitle: new Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: <Widget>[
    //                             SizedBox(height:10.0),
    //                             Text("${camp_data[index]["campname"]} will be organised by ${camp_data[index]["orgname"]}")
    //                           ],
    //                         ),
    //                         contentPadding: EdgeInsets.only(
    //                             left: 10.0, top: 10.0, right: 10.0),
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: <Widget>[
    //                           Text("Date: ${camp_data[index]["date"]} "),
    //                           RaisedButton(
    //                             child: Text(
    //                               "More Details",
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                             onPressed: () => {
    //                               Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()))
    //                             },
    //                             color: Colors.deepPurple,
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //         // width: 250.0,
    //         // margin: EdgeInsets.only(left: 48),
    //       ),
    //       autovalidate: true,
    //     ),
    //   )
    //   :Column(
    //     children:<Widget>[
    //       Center(
    //         heightFactor: 15,
    //         child:CircularProgressIndicator()
    //       )
    //     ],
    //   )

    // );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[180],
        appBar: AppBar(
          title: Text("WellBe Employee"),
          bottom: TabBar(tabs: <Widget>[
            Tab(text: 'Upcoming Camps'),
            Tab(text: 'Already Conducted Camps'),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            upcomingCamps(),
            finishedCamps(),
            
          ],
        ),

        drawer: AppDrawer(),
      ),
    );

  }
}
