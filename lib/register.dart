import 'package:flutter/material.dart';
import 'package:lab2/login.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(Register());

class Register extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<Register> {
  double screenHeight;
  bool _isChecked = false;
  String urlRegister = "https://saujanaeclipse.com/CtHijab/php/register.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
     
      home: Scaffold(
       backgroundColor: Colors.pink[600],
        
        resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              
              upperHalf(context),
              lowerHalf(context),
             
            ],
          )),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 3,
child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "REGISTRATION PAGE",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

 
  Widget lowerHalf(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsets.only(top: screenHeight / 3.5),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _nameEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Name',
                        icon: Icon(Icons.person),
                      )),
                  TextField(
                      controller: _emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Email',
                        icon: Icon(Icons.email),
                      )),
                  TextField(
                      controller: _phoneditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Phone',
                        icon: Icon(Icons.phone),
                      )),
                  TextField(
                    controller: _passEditingController,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Password',
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool value) {
                          _onChange(value);
                        },
                      ),
                      GestureDetector(
                        onTap: _showEULA,
                        child: Text('I Agree to Term',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 115,
                        height: 50,
                        child: Text('Register'),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: _onRegister,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already register? ", 
              style: TextStyle(fontSize: 20.0)
              ),
              GestureDetector(
                onTap: _loginScreen,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
    
  }


  void _onRegister() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneditingController.text;
    String password = _passEditingController.text;
    if (!_isChecked) {
      Toast.show("Please Accept Term", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    http.post(urlRegister, body: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
        Toast.show("Registration success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("End-User License Agreement (EULA) of CtHijab"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                            " 'This End-User License Agreement is a legal agreement between you and Ct Hijab"
                                '\n\n This EULA agreement governs your acquisition and use of our CtHijab software ("Software") directly from Ct Hijab or indirectly through a Ct Hijab authorized reseller or distributor (a "Reseller").'
                                '\n\n Please read this EULA agreement carefully before completing the installation process and using the CtHijab software. It provides a license to use the CtHijab software and contains warranty information and liability disclaimers.'
                                '\n\n This EULA agreement is effective from the date you first use the Software and shall continue until terminated. You may terminate it at any time upon written notice to Ct Hijab'
                                '\n\n It will also terminate immediately if you fail to comply with any term of this EULA agreement. Upon such termination, the licenses granted by this EULA agreement will immediately terminate and you agree to stop all access and use of the Software. The provisions that by their nature continue and survive will survive any termination of this EULA agreemen'
  //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}