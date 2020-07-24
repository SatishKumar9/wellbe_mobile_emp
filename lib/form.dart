import 'package:flutter/material.dart';
import 'functions.dart';
import 'homepage.dart';
import 'userRequests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class employeeForm extends StatefulWidget {
  @override
  _employeeFormState createState() => _employeeFormState();
}

class _employeeFormState extends State<employeeForm> {

  String u_name = '';
  String org_name = '';
  String area = '';
  String remarks = '';
  int n_dbts;
  int n_heart;
  int n_bp;
  int n_ortho;
  int n_lung;
  int n_other;

  @override

  void initState(){
    super.initState();
    getUser();
  }

  void getUser() async {
    localRead("emp_user").then((user) => {
        setState((){
          u_name = user;
          })
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          //key: _formKey,
          child: Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 60.0),
                
                Text(
									"Camp Data",
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 24,
										// color: Colors.white,
									),
								),
                SizedBox(height: 20.0),
                
                Text(
                  "Enter Camp Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontSize: 20,
                    // color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Enter Organisation name",
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
                  onChanged: (String value){
                    org_name=value;
                  },
                  //obscureText: true,
                ),
                
                SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Area/Village",
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
                  onChanged: (String value){
                    area=value;
                  },
                  //obscureText: true,
                ),
                
                SizedBox(height: 45.0),

                Text(
                  "Enter the number of people in each category",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontSize: 20,
                    // color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
          
                new TextFormField(
                  // style: TextStyle(color: Colors.white),
                  //controller: _userNameChannge,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return "Empty User Name";
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Number of diabetes patients",
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
                  onChanged: (String value){
                    n_dbts=int.parse(value);
                  },

                ),
                SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Heart diseases",
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
                  onChanged: (String value){
                    n_heart=int.parse(value);
                  },
                  //obscureText: true,
                ),
                
                SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Abnormal Blood Pressure",
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
                  onChanged: (String value){
                    n_bp=int.parse(value);
                  },
                  //obscureText: true,
                ),
                SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Orthopedic Issues",
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
                  onChanged: (String value){
                    n_ortho=int.parse(value);
                  },
                  //obscureText: true,
                ),
                SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Respiratory Problems",
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
                  onChanged: (String value){
                    n_lung=int.parse(value);
                  },
                  //obscureText: true,
                ),
                SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Other ailments",
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
                  onChanged: (String value){
                    n_other=int.parse(value);
                  },
                  //obscureText: true,
                ),
                
              SizedBox(height: 45.0),
                
                Text(
                  "What are your remarks?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontSize: 20,
                    // color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.0),

              SizedBox(height: 12.0),
                new TextFormField(
          
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Remarks/Observations",
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
                  onChanged: (String value){
                    remarks=value;
                  },
                  //obscureText: true,
                ),
                


                new ButtonBar(
                  children: <Widget>[
                    new RaisedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),

                      onPressed: () {
                        
                        final Map<String,dynamic> CampData={          
                                       "username": u_name,
                                        "org_name": org_name,
                                        "area": area,
                                        "diabetes": n_dbts,
                                        "heart": n_heart,
                                        "bp": n_bp,
                                        "ortho": n_ortho,
                                        "lung": n_lung,
                                        "other": n_other,
                                        "remarks": remarks
                      };
                      print(CampData);
                      http.post(
                        'https://wwxnrgo4id.execute-api.us-east-1.amazonaws.com/test',
                        body:json.encode(CampData)).then((http.Response resp){
                        final Map<String,dynamic> respdata = json.decode(resp.body);
                        print(respdata);//Not really necessary
                      });

                      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));


                        // setState(() {
                        //   user_name = _userNameChannge.text;
                        //   password = _passWordChannge.text;
                        // });
                        // (_formKey.currentState.validate())
                        //     ? _LoginEmployee(user_name, password)
                        //     : null;
                            
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
          //autovalidate: true,-------------------------------------------
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