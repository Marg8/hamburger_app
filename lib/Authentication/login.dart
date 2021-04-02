
import 'package:app_hamburger/Admin/adminLogin.dart';
import 'package:app_hamburger/DialogBox/errorDialog.dart';
import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/DialogBox/loadingDialog.dart';
import 'package:app_hamburger/Widgets/customTextField.dart';
import 'package:app_hamburger/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}





class _LoginState extends State<Login>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width;
    //double _screenHeigh = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 40,),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset("images/icon/icon.png",
                height: 200.0,
                width: 200.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Login to your account",
                  style: TextStyle(color: Colors.black)
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),

            RaisedButton(
              onPressed: () {
                _emailTextEditingController.text.isNotEmpty &&
                    _passwordTextEditingController.text.isNotEmpty ?
                loginUser(): showDialog(context: context,
                builder: (c)
                {
                return ErrorAlertDialog1 (message: "Please write email and password.",);
                }
                );
              },
              color: Colors.orange,
              child: Text("Login", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.orange,
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton.icon(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AdminSignInPage())),
              icon: (Icon(Icons.nature_people, color: Colors.white,)),
              label: Text("i'm admin", style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
    FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async
  {
    showDialog(
        context: context,
    builder: (c)
    {
      return LoadingAlertDialog(message: "Authenticating, Please wait...",);
    });
    User firebaseUser;
    await _auth.signInWithEmailAndPassword(email: _emailTextEditingController.text.trim(), password: _passwordTextEditingController.text.trim(),
    ).then((authUser){
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog1 (message: error.message.toString(),);
          }
      );
    });

      if(firebaseUser != null) {
        readData(firebaseUser).then((s) {
          Navigator.pop(context);
          Route route = MaterialPageRoute(builder: (c) => Hamburger());
          Navigator.push(context, route);
        });
      }
  }


  Future readData(User fUser) async
  {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).get().then((dataSnapshot) async
    {

      await EcommerceApp.sharedPreferences.setString("uid", dataSnapshot.data()[EcommerceApp.userUID]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, dataSnapshot.data()[EcommerceApp.userEmail]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName, dataSnapshot.data()[EcommerceApp.userName]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, dataSnapshot.data()[EcommerceApp.userAvatarUrl]);

      List<String> carList = dataSnapshot.data()[EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, carList);
    });
  }
}

class ErrorAlertDialog {
}
