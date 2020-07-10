import 'package:flutter/material.dart';
import 'package:conver/screens/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:conver/constants.dart';

class OpeningScreen extends StatefulWidget {
  static const String id = 'opening_screen';
  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
//          print("user");

          if (user != null) {
//            Navigator.of(context).pop();
            Navigator.pushNamed(context, Messages.id
//                MaterialPageRoute(
//                    builder: (context) => Messages(
//                          user: user,
//                        ))
                );
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done automaticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.pushNamed(context, Messages.id
//                MaterialPageRoute(
//                    builder: (context) => Messages(
//                          user: user,
//                        ))
                              );
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  String number;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: animation.value,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                  Text(
                    'Conver',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular((30.0))),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          spinner = true;
                        });
                        final phone = _phoneController.text.trim();
                        loginUser(phone, context);
                        setState(() {
                          spinner = false;
                        });
                      } catch (e) {}
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Enter',
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                elevation: 5.0,
                child: TextFormField(
//                maxLength: 10,
//                maxLengthEnforced: true,
                  cursorColor: Colors.green[900],
//                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
//                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    number = (value);
                    print(number);
                  },
                  decoration: InputDecoration(
                    hintText: '+91-0987654321',
                    hintStyle: TextStyle(color: Colors.black54),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                  ),
                  controller: _phoneController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
