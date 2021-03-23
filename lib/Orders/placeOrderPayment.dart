import 'package:app_hamburger/Counters/cartitemcounter.dart';
import 'package:app_hamburger/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:app_hamburger/Config/config.dart';
import '../Config/config.dart';

class PaymentPage extends StatefulWidget {
  final String addressId;
  final double totalAmount;

  PaymentPage({
    Key key,
    this.addressId,
    this.totalAmount,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List cart =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartListID);

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
              TextButton(
                            
                
                onPressed: () => Null,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange
                  ),
                  
                  child: Text(
                    "Entrega a Domicilio",
                    style: TextStyle(fontSize: 30.0,color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset("images/delvham.png"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                            
                
                onPressed: () => addOrderDetails(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange
                  ),
                  
                  child: Text(
                    "Confirmar Orden",
                    style: TextStyle(fontSize: 30.0,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addOrderDetails() {
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.userCartList2)
        .getDocuments();

    writeOrderDetailsForUser({
      EcommerceApp.addressID: widget.addressId,
      EcommerceApp.totalAmount: widget.totalAmount,
      "orderBy": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID: EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartListID),
      EcommerceApp.paymentDetails: "Pago en efectivo",
      EcommerceApp.orderTime: DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess: true,
    });

    writeOrderDetailsForAdmin({
      EcommerceApp.addressID: widget.addressId,
      EcommerceApp.totalAmount: widget.totalAmount,
      "orderBy": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID: EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartListID),
      EcommerceApp.paymentDetails: "Pago en efectivo",
      EcommerceApp.orderTime: DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess: true,
    }).whenComplete(() => {
          emptyCartNow(),
          emptyCartNowID(),
          cartDataOrder(cart),
        });
  }

  emptyCartNow() {
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
    List tempList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);

    Firestore.instance
        .collection("users")
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: tempList,
    }).then((value) {
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
    Fluttertoast.showToast(msg: "Felizidades, Tu Ordern ha sido Recibida.");

    Route route = MaterialPageRoute(builder: (c) => Hamburger());
    Navigator.push(context, route);
  }

  emptyCartNowID() {
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartListID, ["garbageValue"]);
    List tempList = EcommerceApp.sharedPreferences
        .getStringList(EcommerceApp.userCartListID);

    Firestore.instance
        .collection("users")
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartListID: tempList,
    }).then((value) {
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartListID, tempList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
    Fluttertoast.showToast(msg: "Felizidades, Tu Ordern ha sido Recibida.");

    Route route = MaterialPageRoute(builder: (c) => Hamburger());
    Navigator.push(context, route);
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) +
                data['orderTime'])
        .setData(data);
  }

  Future writeOrderDetailsForAdmin(Map<String, dynamic> data) async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionOrders)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) +
                data['orderTime'])
        .setData(data);
  }
}

//  Future getdata(List<int> cart) async {
//     QuerySnapshot snap = await EcommerceApp.firestore
//         .collection(EcommerceApp.collectionUser)
//         .document(
//             EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//         .collection(EcommerceApp.userCartList)
//         .getDocuments();

//     snap.documents.forEach((document) {
//       final cart = document.documentID;
//       print(cart);
//       return cart;
//     });
//   }

Future cartDataOrder(List cart) async {
  WriteBatch batch = EcommerceApp.firestore.batch();

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection(EcommerceApp.userCartList2)
      .getDocuments()
      .then((querySnapshot) {
    querySnapshot.documents.forEach((productId) {
      try {
        if (cart.contains(productId.documentID.toString())) {
          batch.updateData(productId.reference, {"status": "Order"});
        }
      } on FormatException catch (error) {
        print("The document ${error.source} could not be parsed.");
        return null;
      }
    });
    return batch.commit();
  });
}

//   CollectionReference _collectionRef =
//      EcommerceApp.firestore
//         .collection(EcommerceApp.collectionUser)
//         .document(
//             EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//         .collection(EcommerceApp.userCartList);

// Future<void> getData() async {
//     // Get docs from collection reference
//     QuerySnapshot querySnapshot = await _collectionRef.get();

//     // Get data from docs and convert map to List
//     final allData = querySnapshot.documents.
//     map((doc) => doc.data).toList();

//     print(allData);
// }

//intentos
// List<int> get cart {
//   EcommerceApp.firestore
//       .collection(EcommerceApp.collectionUser)
//       .document(
//           EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//       .collection(EcommerceApp.userCartList)
//       .getDocuments();

// }

// Future get cart async {
//   QuerySnapshot snap = await EcommerceApp.firestore
//       .collection(EcommerceApp.collectionUser)
//       .document(
//           EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//       .collection(EcommerceApp.userCartList)
//       .getDocuments();

//       for (int i = 0; i < snap.documents.length; i++) {
//         var a = snap.documents[i];
//         print(a.documentID);
//         return a.documentID;
//       }

//   // final List cart = snap.documents;

//   // snap.documents.forEach((document) {
//   //   final cart = document.documentID.toString();

//   //   return cart;
//   // });

// }

// Future getDocs(List<int> cart) async {
//   QuerySnapshot querySnapshot = await EcommerceApp.firestore
//       .collection(EcommerceApp.collectionUser)
//       .document(
//           EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//       .collection(EcommerceApp.userCartList)
//       .getDocuments();
//   for (int i = 0; i < querySnapshot.documents.length; i++) {
//     var a = querySnapshot.documents[i];
//     print(a.documentID);
//     final cart = a.documentID;
//     return cart;
//   }
// }

//   List<int> cart = [
// 1615791984072,1615791987965

// ];
