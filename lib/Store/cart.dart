import 'package:app_hamburger/Address/address.dart';
import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/Counters/cartitemcounter.dart';
import 'package:app_hamburger/Counters/totalMoney.dart';
import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Store/storehome.dart';
import 'package:app_hamburger/Widgets/customAppBar.dart';
import 'package:app_hamburger/Widgets/loadingWidget.dart';
import 'package:app_hamburger/Widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length == 1) {
            Fluttertoast.showToast(msg: "Your Cart is empty");
          }
          else {
            Route route = MaterialPageRoute(builder: (c) => Address(totalAmount: totalAmount));
            Navigator.push(context, route);
          }
        },
        label: Text("Comprar Ahora"),
        backgroundColor: Colors.black,
        icon: Icon(Icons.navigate_next),
      ),
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(
                builder: (context, amountProvider, cartProvider, c) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: cartProvider.count == 0
                      ? Container()
                      : Text(
                          r"Precio Total: $" + "${amountProvider.totalAmount.toInt()} MXN",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                ),
              );
            }),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: EcommerceApp.firestore
                  .collection("items")
                  .where("title",
                      whereIn: EcommerceApp.sharedPreferences
                          .getStringList(EcommerceApp.userCartList))
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : snapshot.data.documents.length == 0
                        ? beginBuildingCart()
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                ItemModel model = ItemModel.fromJson(
                                    snapshot.data.documents[index].data);

                                if (index == 0) {
                                  totalAmount = 0;
                                  totalAmount = model.price + totalAmount;
                                } else {
                                  totalAmount = model.price + totalAmount;
                                }

                                if (snapshot.data.documents.length - 1 == index) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((c) {
                                    Provider.of<TotalAmount>(context,
                                            listen: false)
                                        .display(totalAmount);
                                  });
                                }
                                return sourceInfo(model, context,
                                    removeCartFunction: () =>
                                        removeItemFromUserCart(
                                            model.title));
                              },
                              childCount: snapshot.hasData
                                  ? snapshot.data.documents.length
                                  : 0,
                            ),
                          );
              })
        ],
      ),
    );
  }

  beginBuildingCart()
  {
    return SliverToBoxAdapter(
      child: Container(
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.insert_emoticon, color: Colors.black,),
            Text("Cart is empty"),
            Text("Star adding items to your Cart"),
          ],
        ),
      ),
    );
  }

  removeItemFromUserCart(String titleAsId)
  {
    List temCartList =
    EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    temCartList.remove(titleAsId);

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: temCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Item RemovedSuccessfully.");

      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, temCartList);

      Provider.of<CartItemCounter>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }
}
