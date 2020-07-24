import 'package:flutter/material.dart';
import 'package:wellbeEmp/form.dart';
import 'homepage.dart';
import 'login.dart';
import 'functions.dart';
import 'login.dart';
import 'userRequests.dart';

class AppDrawer extends StatefulWidget {
  @override
  _drawer createState() => _drawer();
}

class _drawer extends State<AppDrawer> {
  var user;
  var name;
  var emp;
  var emp_name;
  Widget show;

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

  @override
  void initState() {
    super.initState();
    get_emp();
  }

  Widget _createHeader(name) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     // fit: BoxFit.fill,
      //     image: AssetImage('assets/images/logo_size_android.jpg'),
      //   ),
      // ),
      child: Center(
        child: Image(
          image: AssetImage('assets/images/logo_size_android.jpg'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createHeader(name),
          // Container(
          //   height: 40.0,
          //   color: Color(0xFF008080),
          // ),
          // SizedBox(
          //   child: Container(
          //     child: Row(
          //       children: <Widget>[
          //         Icon(
          //           Icons.person,
          //           color: Colors.white,
          //           size: 60.0,
          //         ),
          //         SizedBox(width: 40),
          //         (emp != null)
          //             ? Row(
          //                 children: <Widget>[
          // //                   Text(
          //                     "Hello ",
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   Text(
          //                     emp_name,
          //                     style: TextStyle(
          //                       fontSize: 18,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   FlatButton(
          //                       child: Text("Log Out"),
          //                       onPressed: () {
          //                         logoutEmployee();
          //                       })
          //                 ],
          //               )
          //             : FlatButton(
          //                 child: Text("Employee Login"),
          //                 onPressed: () {
          //                   Navigator.push(
          //                       context,
          //                       new MaterialPageRoute(
          //                           builder: (context) => LoginPage()));
          //                 },
          //               ),
          //       ],
          //     ),
          //     color: Color(0xFF008080),
          //   ),
          //   // height: 25.0,
          // ),
          FlatButton(
            child: Text("Home    "),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          FlatButton(
            child: Text("  Fundraiser Requests"),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => UserRequestFund()));
            },
          ),
          FlatButton(
            child: Text("  Fill Details"),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => employeeForm()));
            },
          ),
          FlatButton(
            child: Text("Log Out"),
            onPressed: () {
              logoutEmployee();
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
