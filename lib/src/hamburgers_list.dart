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

Widget sourceInfoBurger(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  int items = 10;

  //  bool reverse = index.isEven;

  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
      Navigator.push(context, route);
    },
    splashColor: Colors.black,
    child: removeCartFunction == null
        ? Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 1, right: 1),
                height: 240,
                width: 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(BurgerPage.tag);
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
                                Text(model.price.toString(),
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
                right: 10,
                // child: GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pushNamed(BurgerPage.tag);
                //   },
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
              )
            ],
          )
        : Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 240,
                width: 200,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(BurgerPage.tag);
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
                                Text(model.price.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: removeCartFunction == null
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              checkItemInCart(
                                                  model.title, context);
                                            },
                                          )
                                        : IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              removeCartFunction();

                                              //opcional para salir automati
                                              Route route = MaterialPageRoute(
                                                  builder: (c) => Hamburger());
                                              Navigator.push(context, route);
                                            },
                                          ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
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
                    Navigator.of(context).pushNamed(BurgerPage.tag);
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
                ),
              )
            ],
          ),
  );
}
