// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../Widgets/loadingWidget.dart';

// class AdminShiftOrders extends StatefulWidget {
//   @override
//   _MyOrdersState createState() => _MyOrdersState();
// }


// class _MyOrdersState extends State<AdminShiftOrders> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(color:Colors.white),
//           flexibleSpace: Container(
//             decoration: new BoxDecoration(
//               gradient: new LinearGradient(
//                 colors: [Color(theme),Color(theme)],
//                 begin: const FractionalOffset(0.0, 0.0),
//                 end: const FractionalOffset(1.0,0.0),
//                 stops: [0.0,1.0],
//                 tileMode: TileMode.clamp,
//               ),
//             ),
//           ),
//           centerTitle: true,
//           title: Text("My Orders Admin", style: TextStyle(color: Colors.white),),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.arrow_drop_down_circle, color: Colors.white,),
//               onPressed: ()
//               {
//                 SystemNavigator.pop();
//               },
//             ),
//           ],
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: Firestore.instance.collection("orders").snapshots(),

//           builder: (c, snapshot)
//           {
//             return snapshot.hasData
//                 ? ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               padding: const EdgeInsets.only( top: 20.0),
//               itemBuilder: (c, index){
                
//                 return FutureBuilder<QuerySnapshot>(
//                   future: Firestore.instance.collection("items")
//                       .where("title", whereIn: snapshot.data.documents[index].data[EcommerceApp.productID])
//                       .getDocuments(),

//                   builder: (c, snaps)
//                   {
//                     return snaps.hasData
//                         ? AdminOrderCard(
//                       itemCount: snaps.data.documents.length,
//                       data: snaps.data.documents,
//                       orderID: snapshot.data.documents[index].documentID,
//                       orderBy: snapshot.data.documents[index].data["orderBy"],
//                       addressID: snapshot.data.documents[index].data["addressID"],
//                     )
//                         :Center(child: circularProgress(),);
//                   },
//                 );
//               },
//             )
//                 : Center(child: circularProgress(),);
//           },
//         ),
//       ),
//     );
//   }
// }
