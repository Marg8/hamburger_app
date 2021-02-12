import 'package:app_hamburger/src/categories.dart';
import 'package:app_hamburger/src/hamburgers_list.dart';
import 'package:app_hamburger/src/header.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
      home: Hamburger(),
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
            leading: IconButton(icon:Icon(Icons.menu), onPressed: (){}),
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
    );
  }
}


    
