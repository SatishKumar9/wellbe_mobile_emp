import 'dart:convert';
import 'package:flutter/material.dart';
import 'functions.dart';
import 'package:http/http.dart';
import 'homepage.dart';
import 'drawer.dart';

class EmpForgotPass extends StatefulWidget {
	@override
	_EmpForgotPassState createState() => _EmpForgotPassState();
}

class _EmpForgotPassState extends State<EmpForgotPass> {

	bool error = false;
	String error_msg = "";
	bool en_pass = false;
	TextEditingController _user_name = TextEditingController();
	TextEditingController _pass = TextEditingController();

	final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

	Future<void> verifyEmp(String phone_no, String user_name) async {
		final uri = 'https://m24j52esy5.execute-api.us-east-1.amazonaws.com/test';
		final headers = {'Content-Type': 'application/json'};
		Map<String, dynamic> body = {
			"phone_no": phone_no,
			"user_name": user_name
		};
		print(body);
		Response response = await post(
			uri,
			headers: headers,
			body: jsonEncode(body),
		);

		var resp = jsonDecode(response.body);
		print(resp);
		if(resp['status'] == 0){
			showDialog(
				context: context,
				builder: (BuildContext context) {
					return new AlertDialog(
						title: new Text("User unverified"),
						content: new Text("The entered User Name doesn't match with the registered mobile number within the device. Please tr again after some time."),
						actions: <Widget>[
							new FlatButton(
								onPressed: (){
									Navigator.push(
										context, 
										new MaterialPageRoute(builder: (context) => HomePage())
									);
								}, 
								child: new Text("Close"))
						],
					);
				} 
			);
		}
		else{
			setState(() {
				en_pass = true;
			});
		}

	}

	Future<void> submit_pass() async {
		final uri = 'https://o9ssgm5azi.execute-api.us-east-1.amazonaws.com/test';
		final headers = {'Content-Type': 'application/json'};
		Map<String, dynamic> body = {
			"password": _pass.text,
			"user_name": _user_name.text
		};
		Response response = await post(
			uri,
			headers: headers,
			body: jsonEncode(body),
		);

		var resp = jsonDecode(response.body);
		print(resp);
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return new AlertDialog(
					title: new Text("Password Changed"),
					content: new Text("Your password was changed successfully."),
					actions: <Widget>[
						new FlatButton(
							onPressed: (){
								Navigator.push(
									context, 
									new MaterialPageRoute(builder: (context) => HomePage())
								);
							}, 
							child: new Text("Close"))
					],
				);
			} 
		);
	}


	empVerify(){
		fillMobileNumber().then((phone_no){
			print(phone_no);
			verifyEmp(phone_no, _user_name.text);
		});
	}

	@override 
	Widget build(BuildContext context){
		bool _otpvalid = true, _phvalid = true;
		final _formKey = GlobalKey<FormState>();
		return Scaffold(
			key: _scaffoldKey,
			body: SafeArea(
				child: new Container(
					child: new Form(
						key: _formKey,
						child: ListView(
							padding: EdgeInsets.symmetric(horizontal: 24.0),
							children: <Widget>[
								SizedBox(height: 100.0),
								Text(
									"Forgot password",
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 24,
										// color: Colors.white,
									),
								),
								SizedBox(height: 20.0),
								Text(
									"Enter Username of your registered mobile number. Please make sure that the registered SIM is placed in SIM Slot 1 in your device.",
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 20.0),
								new TextFormField(
									controller: _user_name,
									// style: TextStyle(color: Colors.white),									
									validator: (value){
										if (value.isEmpty){
											return "Invalid User Name";
										}
										return null;
									},
									decoration: InputDecoration(
										border: InputBorder.none,
										labelText: "User Name",
										filled: true,
										labelStyle: TextStyle(
											color: Colors.grey,
										) ,
										errorStyle: TextStyle(
											color: Colors.grey,
										),
										errorBorder: OutlineInputBorder(
											borderSide: const BorderSide(color: Colors.grey, width: 1.0),
											borderRadius: BorderRadius.circular(10.0),
										),
										focusedBorder:OutlineInputBorder(
											borderSide: const BorderSide(color: Colors.blue, width: 2.0),
											borderRadius: BorderRadius.circular(10.0),
										),
									),
								),
								SizedBox(height: 12.0),
								new ButtonBar(
									children: <Widget>[
										new RaisedButton(
											child: Text(
												"Request New Password",
												// style: TextStyle(color: Colors.white),
											),
											padding: EdgeInsets.symmetric(
												horizontal: 10.0,
												vertical: 7.5
											),
											highlightColor: Colors.white,
											onPressed: () {
												(_user_name.text.isNotEmpty) ? empVerify(): null;
											},
											// borderSide: BorderSide(color: Colors.white),
											// shape: StadiumBorder(),
                      color: Colors.blue,
										)
									],
									alignment: MainAxisAlignment.center,
								),
                SizedBox(height: 20.0),
								new TextFormField(
									enabled: en_pass,
									controller: _pass,
									// style: TextStyle(color: Colors.white),									
									validator: (value){
										if (value.isEmpty){
											return "Empty password";
										}
										return null;
									},
									obscureText: true,
									decoration: InputDecoration(
										border: InputBorder.none,
										labelText: "New Password",
										filled: true,
										labelStyle: TextStyle(
											color: Colors.grey,
										) ,
										errorStyle: TextStyle(
											color: Colors.grey,
										),
										errorBorder: OutlineInputBorder(
											borderSide: const BorderSide(color: Colors.grey, width: 1.0),
											borderRadius: BorderRadius.circular(10.0),
										),
										focusedBorder:OutlineInputBorder(
											borderSide: const BorderSide(color: Colors.blue, width: 2.0),
											borderRadius: BorderRadius.circular(10.0),
										),
									),
								),
								SizedBox(height: 12.0),
								new ButtonBar(
									children: <Widget>[
										new RaisedButton(
											child: Text(
												"Submit Password",
												// style: TextStyle(color: Colors.white),
											),
											padding: EdgeInsets.symmetric(
												horizontal: 10.0,
												vertical: 7.5
											),
											highlightColor: Colors.white,
											onPressed: () {
												(_formKey.currentState.validate() & en_pass) ? submit_pass(): null;
											},
											// borderSide: BorderSide(color: Colors.white),
											// shape: StadiumBorder(),
                      color: Colors.blue,
										)
									],
									alignment: MainAxisAlignment.center,
								),
							],
						),
						autovalidate: true,
					),
					// decoration: BoxDecoration(
					// 	gradient: LinearGradient(
					// 		begin: Alignment.topRight,
					// 		end: Alignment.bottomLeft,
					// 		colors: [Colors.blue, Colors.teal]
					// 	)
					// ),

				),
			),
		);
	}
}