import 'dart:async';

import 'package:app_hamburger/Authentication/authenication.dart';
import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/Widgets/myDrawer.dart';
import 'package:app_hamburger/src/burger_page.dart';
import 'package:app_hamburger/src/categories.dart';
import 'package:app_hamburger/src/hamburgers_list.dart';
import 'package:app_hamburger/src/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;

  

   return runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardColor: Colors.teal,
        appBarTheme: AppBarTheme(color: Colors.teal,centerTitle: true),
        bottomAppBarColor: Colors.teal,
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.orange)  
      ),
      home:  SplashScreen(),
      // routes: {BurgerPage.tag: (_)=>BurgerPage()},
      debugShowCheckedModeBanner: false,
              );
            }
          
            
    }
    
class Hamburger extends StatefulWidget {


  @override
  _HamburgerState createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text("Chiken-Mac",style: TextStyle(fontSize: 30),),
            // leading: IconButton(icon:Icon(Icons.menu), onPressed: (){
            
            // }),
            actions: [IconButton(icon: Icon(Icons.shopping_bag), onPressed: (){})],
            
          ),
         
          Header(),
          Categories(),
          HamburgerList(row: 1,),
          HamburgerList(row: 2,),
          

        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.home),
        ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),        
          child: Row(
            children: [
              Spacer(),
              IconButton(icon: Icon(Icons.add_alert),
              color: Colors.white, 
              onPressed: (){}
              ),
              Spacer(),
              Spacer(),
              IconButton(icon: Icon(Icons.turned_in), 
              color: Colors.white,
              onPressed: (){}
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      drawer:  MyDrawer(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState(){
    super.initState();

    displaySplash();
  }

  displaySplash()
  {
    Timer(Duration(seconds: 3),() async{
      if(await EcommerceApp.auth.currentUser() != null)
        {
          Route route = MaterialPageRoute(builder: (_) => Hamburger());
          Navigator.push(context, route);
        }
      else
        {
          Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
          Navigator.push(context, route);
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.white, Colors.white],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/chikenmaclogo.png",
              height: 200.0,
              width: 240.0,
                ),
              SizedBox(height: 20.0,),
              Text("Chiken-Mac",
              style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),

            ],

          ),
        ),
      ),
    );
  }
}


    
