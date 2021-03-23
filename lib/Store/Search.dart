
import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Store/storehome.dart';
import 'package:app_hamburger/Widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../Widgets/customAppBar.dart';
import '../main.dart';




class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => new _SearchProductState();
}



class _SearchProductState extends State<SearchProduct>
{

  Future<QuerySnapshot> docList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(bottom: PreferredSize(child: searchWidget(), preferredSize: Size(56.0, 56.0)),),
        drawer: MyDrawer(),
        body: FutureBuilder<QuerySnapshot>(
          future: docList,
          builder: (context, snap)
          {
            return snap.hasData
                ? ListView.builder(
                itemCount: snap.data.documents.length,
                itemBuilder: (context, index)
            {
              ItemModel model = ItemModel.fromJson(snap.data.documents[index].data);

              return sourceInfo(model, context);
            },
            )
                : Text("Escriba en Area de buscador para ontener informacion");
          },
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => Hamburger());
            Navigator.push(context, route);
          },
          child: Icon(Icons.home),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
              children: [
                Spacer(),
                IconButton(
                    icon: Icon(Icons.add_alert),
                    color: Colors.white,
                    onPressed: () {}),
                Spacer(),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.turned_in),
                    color: Colors.white,
                    onPressed: () {}),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchWidget()
  {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.teal, Colors.teal],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0,0.0),
          stops: [0.0,1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width -40,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(Icons.search, color: Colors.blueGrey,),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  onChanged: (value)
                  {
                    startSearching(value);
                  },
                  decoration: InputDecoration.collapsed(hintText: "Busqueda Avanzada"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  
  Future startSearching(String query)
  {
         docList = Firestore.instance.collection("items")
        .where("title", isGreaterThanOrEqualTo: query)
        .getDocuments();

        return docList;
  }
}

