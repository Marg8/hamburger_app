
import 'package:app_hamburger/Admin/adminOrderCard.dart';
import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/Widgets/loadingWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AdminShiftOrders1 extends StatefulWidget {
  @override
  _AdminShiftOrders1State createState() => _AdminShiftOrders1State();
}


class _AdminShiftOrders1State extends State<AdminShiftOrders1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color:Colors.white),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.teal,Colors.teal],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0,0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          centerTitle: true,
          title: Text("My Orders Admin", style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_drop_down_circle, color: Colors.white,),
              onPressed: ()
              {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("orders").snapshots(),

          builder: (c, snapshot)
          {
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              padding: const EdgeInsets.only( top: 20.0),
              itemBuilder: (c, index){
                
                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection("items")
                      .where("title", whereIn: snapshot.data.docs[index].data()[EcommerceApp.productID])
                      .get(),

                  builder: (c, snaps)
                  {
                    return snaps.hasData
                        ? AdminOrderCard(
                      itemCount: snaps.data.docs.length,
                      data: snaps.data.docs,
                      orderID: snapshot.data.docs[index].id,
                      orderBy: snapshot.data.docs[index].data()["orderBy"],
                      addressID: snapshot.data.docs[index].data()["addressID"],
                    )
                        :Center(child: circularProgress(),);
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}
