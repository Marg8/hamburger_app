import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/Counters/cartitemcounter.dart';
import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Store/product_page.dart';
import 'package:app_hamburger/Store/storehome.dart';
import 'package:app_hamburger/Widgets/loadingWidget.dart';
import 'package:app_hamburger/Widgets/searchBox.dart';
import 'package:app_hamburger/main.dart';
import 'package:app_hamburger/src/burger_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

Widget sourceInfoBurger(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  int items = 10;

  //  bool reverse = index.isEven;

  return removeCartFunction == null
      ? Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 1, right: 1),
              height: 240,
              width: 180,
              child: GestureDetector(
                onTap: () {
                  Route route = MaterialPageRoute(
                      builder: (c) => ProductPage(itemModel: model));
                  Navigator.push(context, route);
                },
                child: Card(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              model.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              Text(r"$",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text("${model.price.toString()}.0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              removeCartFunction == null
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        checkItemInCart(model.title, context);
                                        checkProductIdinCart(
                                            model.title, model, context);
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        removeCartFunction();

                                        //opcional para salir automatico

                                        Route route = MaterialPageRoute(
                                            builder: (c) => Hamburger());
                                        Navigator.push(context, route);
                                      },
                                    ),
                            ],
                          )
                        ],
                      )),
                  elevation: 3,
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45))),
                ),
              ),
            ),
            Positioned(
                top: 50,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (c) => ProductPage(itemModel: model));
                    Navigator.push(context, route);
                  },
                  child: Container(
                    height: 160,
                    width: 190,
                    child: FadeInImage(
                      image: NetworkImage(model.thumbnailUrl),
                      placeholder: AssetImage("images/loading.png"),
                      fadeInDuration: Duration(milliseconds: 50),
                      width: 140.0,
                      height: 140.0,
                    ),
                  ),
                  // ),
                ))
          ],
        )
      : Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 200,
              width: 500,
              child: GestureDetector(
                onTap: () {
                  Route route = MaterialPageRoute(
                      builder: (c) => ProductPage(itemModel: model));
                  Navigator.push(context, route);
                },
                child: Card(
                  child: Table(
                    children: [
                      TableRow(children: [
                        Container(
                          height: 180.0,
                          width: 50,
                          child: Row(
                            children: [
                              Image.network(
                                model.thumbnailUrl,
                                width: 140.0,
                                height: 140.0,
                              ),
                              SizedBox(
                                width: 1.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              model.title ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              model.shortInfo ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    r"",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    r"$",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    (model.cartPrice ?? '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 170,
                                          child: CantidadProducto(model),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: removeCartFunction == null
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    checkItemInCart(
                                                        model.title, context);
                                                    checkProductIdinCart(
                                                        model.title,
                                                        model,
                                                        context);
                                                    checkItemInCart2(
                                                        model.productId,
                                                        context);
                                                  },
                                                )
                                              : IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    removeCartFunction();

                                                    //opcional para salir automatico

                                                    Route route =
                                                        MaterialPageRoute(
                                                            builder: (c) =>
                                                                Hamburger());
                                                    Navigator.push(
                                                        context, route);
                                                  },
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ])
                    ],
                  ),
                  elevation: 3,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45))),
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: GestureDetector(
                onTap: () {
                  Route route = MaterialPageRoute(
                      builder: (c) => ProductPage(itemModel: model));
                  Navigator.push(context, route);
                },
                child: Row(
                  children: [],
                ),
              ),
            )
          ],
        );
}

checkItemInCart(String titleAsID, BuildContext context) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(titleAsID.toString())
      ? Fluttertoast.showToast(msg: "Articulo ya existe en Carrito.")
      : addItemToCart(titleAsID, context);
}

checkProductIdinCart(String tittleAsId, ItemModel model, BuildContext context) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(tittleAsId.toString())
      ? Fluttertoast.showToast(msg: "Articulo ya existe.")
      : saveItemInfoUserCart(tittleAsId, model, context);
}

checkItemInCart2(String productId, BuildContext context) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(productId.toString())
      ? Fluttertoast.showToast(msg: "Articulo ya existe en Carrito.")
      : addItemToCart2(productId, context);
}

addItemToCart(String titleAsID, BuildContext context) {
  List temCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  temCartList.add(titleAsID);

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartList: temCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Agregado con exito.");

    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, temCartList);

    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}

addItemToCart2(String productId, BuildContext context) {
  List temCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartListID);
  temCartList.add(productId);

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartListID: temCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Agregado con exito.");

    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartListID, temCartList);

    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}

saveItemInfoUserCart(String tittleAsId, ItemModel model, BuildContext context) {
  String productId = DateTime.now().millisecondsSinceEpoch.toString();

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection(EcommerceApp.userCartList2)
      .document(productId)
      .setData({
    "shortInfo": model.shortInfo.toString(),
    "longDescription": model.longDescription.toString(),
    "price": model.price.toInt(),
    "cartPrice": model.price.toInt(),
    "publishedDate": DateTime.now(),
    "status": "available",
    "thumbnailUrl": model.thumbnailUrl,
    "title": model.title.toString(),
    "qtyitems": model.qtyitems.toInt(),
    "productId": productId
  }).whenComplete(() {
    checkItemInCart2(productId, context);
  });
}

class CantidadProducto extends StatefulWidget {
  final ItemModel model;
  CantidadProducto(this.model);

  @override
  _CantidadProductoState createState() => _CantidadProductoState(this.model);
}

class _CantidadProductoState extends State<CantidadProducto> {
  _CantidadProductoState(this.model);
  final ItemModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                onPressed: () {
                  int min = widget.model.qtyitems;
                  if (min > 1) {
                    _removeProd();
                  }else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              "${widget.model.qtyitems}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  int max = widget.model.qtyitems;
                  if (max < 20) {
                    _addProd();
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _addProd() {
    widget.model.qtyitems++;

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.userCartList2)
        .document(widget.model.productId.toString())
        .updateData({
      "price": widget.model.price.toInt(),
      "cartPrice": widget.model.price.toInt() * widget.model.qtyitems.toInt(),
      "qtyitems": widget.model.qtyitems.toInt(),
    });
  }

  _removeProd() {
    widget.model.qtyitems--;

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.userCartList2)
        .document(widget.model.productId.toString())
        .updateData({
      "price": widget.model.price.toInt(),
      "cartPrice": widget.model.price.toInt() * widget.model.qtyitems.toInt(),
      "qtyitems": widget.model.qtyitems.toInt(),
    });
  }
}
