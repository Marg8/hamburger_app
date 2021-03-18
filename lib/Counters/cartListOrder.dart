import 'package:app_hamburger/Config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartListOrder extends ChangeNotifier {
  Future getdata(List<int> cart) async {
    QuerySnapshot snap = await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.userCartList)
        .getDocuments();

    snap.documents.forEach((document) {
      final cart = document.documentID;
      print(cart);
      return cart;
    });
     await Future.delayed(const Duration(microseconds: 100), () {
      notifyListeners();
    });
  }
}
