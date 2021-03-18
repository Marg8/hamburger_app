import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/Counters/cartitemcounter.dart';
import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Store/storehome.dart';
import 'package:app_hamburger/Widgets/loadingWidget.dart';

import 'package:app_hamburger/main.dart';
import 'package:app_hamburger/src/burger_page.dart';
import 'package:app_hamburger/src/categories.dart';
import 'package:app_hamburger/src/hamburgers_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  final ItemColorModel modelcolor;
  ProductPage({this.itemModel, this.modelcolor});
  @override
  _ProductPageState createState() => _ProductPageState();
}

List<dynamic> _colores = ["Negro", "Verde", "Amarillo", "Azul", ""];
String opcionesColor = "";

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              AgregadosCompras(),
            ],
          ),
          body: buildListView(context)),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: [
        Container(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
          width: MediaQuery.of(context).size.width,
          color: Colors.teal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(children: [
                SizedBox(width: 20),
                Text(
                  widget.itemModel.title,
                  style: boldTextStyle1,
                ),
              ]),

              Row(children: [
                SizedBox(width: 20),
                Text(
                  widget.itemModel.shortInfo,
                  style: boldTextStyle,
                ),
              ]),

              Row(children: [
                Container(
                  child: Image.network(
                    widget.itemModel.thumbnailUrl,
                  ),
                  width: 200,
                  height: 200,
                ),
                InofrmacionProducto(widget.itemModel),
              ]),

              SizedBox(height: 20.0),

              MultipleOptions(
                widget: widget,
              ),

              // OnClickforAddToCart(widget: widget),
            ],
          ),
        ),
      ],
    );
  }
}

class InofrmacionProducto extends StatefulWidget {
  final ItemModel itemModel;
  InofrmacionProducto(this.itemModel);

  @override
  _InofrmacionProductoState createState() =>
      _InofrmacionProductoState(this.itemModel);
}

class _InofrmacionProductoState extends State<InofrmacionProducto> {
  _InofrmacionProductoState(this.itemModel);
  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1, bottom: 0, left: 30, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          buildText(),
          SizedBox(
            height: 3.0,
          ),
          Text(
            r"$ " + widget.itemModel.price.toString() + ".0 MXN",
            style: boldTextStyle,
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.white),
              Icon(Icons.star, color: Colors.white),
              Icon(Icons.star, color: Colors.white),
              Icon(Icons.star, color: Colors.white),
              Icon(Icons.star, color: Colors.white),
            ],
          )
        ],
      ),
    );
  }

  Text buildText() {
    setState(() {
      widget.itemModel.qtyitems.toString();
    });
    return Text(
      "Cantidad: " + widget.itemModel.qtyitems.toString(),
      style: boldTextStyle,
    );
  }
}

class MultipleOptions extends StatelessWidget {
  const MultipleOptions({Key key, this.widget});
  final ProductPage widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 100, left: 25, right: 25),
        child: Column(
          children: <Widget>[
            TouchPill(),

            SizedBox(height: 16),
            Container(
              child: Text("Descripcion"),
            ),
            SizedBox(height: 20.0),

            Row(
              children: [
                Text(
                  "Ingredientes:",
                  style: boldTextStyle2,
                ),
              ],
            ),

            SizedBox(height: 20.0),
            Text(
              widget.itemModel.longDescription,
              style: largeTextStyle,
            ),
            SizedBox(height: 70),

            //controls
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                      onTap: () {
                        checkItemInCart1(widget.itemModel.title, context);

                        checkProductIdinCart(widget.itemModel.title, widget.itemModel,context);
                      },
                      child: AddToCartBottom()),
                ),
                SizedBox(width: 10),
                // Expanded(
                //   child: CantidadProducto(widget.itemModel),
                // ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void checkItemInCart1(String titleAsID, BuildContext context) {
    EcommerceApp.sharedPreferences
            .getStringList(EcommerceApp.userCartList)
            .contains(titleAsID.toString())
        ? Fluttertoast.showToast(msg: "Articulo ya existe en Carrito.")
        : addItemToCart(titleAsID, context);
  }

  addItemToCart(String titleAsID, BuildContext context) {
    List temCartList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    temCartList.add(titleAsID);

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: temCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Agregado con exito.");

      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, temCartList);

      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
  }

  checkProductIdinCart(
      String tittleAsId, ItemModel itemModel, BuildContext context) {
    EcommerceApp.sharedPreferences
            .getStringList(EcommerceApp.userCartList)
            .contains(tittleAsId.toString())
        ? Fluttertoast.showToast(msg: "Articulo ya existe.")
        : saveItemInfoUserCart(tittleAsId, itemModel, context);
  }

  saveItemInfoUserCart(
      String tittleAsId, ItemModel itemModel, BuildContext context) {
    String productId = DateTime.now().millisecondsSinceEpoch.toString();

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.userCartList2)
        .document(productId)
        .setData({
      "shortInfo": widget.itemModel.shortInfo.toString(),
      "longDescription": widget.itemModel.longDescription.toString(),
      "price": widget.itemModel.price.toInt(),
      "cartPrice": widget.itemModel.price.toInt(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": widget.itemModel.thumbnailUrl,
      "title": widget.itemModel.title.toString(),
      "qtyitems": widget.itemModel.qtyitems.toInt(),
      "productId": productId
      
    });
  }
}

class AddToCartBottom extends StatelessWidget {
  const AddToCartBottom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(48),
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.orange],
          ),
        ),
        child: Text(
          "Agregar Compra",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// class CantidadProducto extends StatefulWidget {
//   final ItemModel itemModel;
//   CantidadProducto(this.itemModel);

//   @override
//   _CantidadProductoState createState() =>
//       _CantidadProductoState(this.itemModel);
// }

// class _CantidadProductoState extends State<CantidadProducto> {
//   _CantidadProductoState(this.itemModel);
//   final ItemModel itemModel;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(28),
//         border: Border.all(
//           color: Colors.teal,
//           width: 2,
//         ),
//       ),
//       child: Row(
//         children: <Widget>[
//           Container(
//             width: 50.0,
//             height: 50.0,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.orange,
//             ),
//             child: Container(
//               child: IconButton(
//                 icon: Icon(
//                   Icons.remove,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     widget.itemModel.qtyitems--;
//                   });
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               "${widget.itemModel.qtyitems}",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Container(
//             width: 50.0,
//             height: 50.0,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.orange,
//             ),
//             child: Container(
//               child: IconButton(
//                 icon: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     widget.itemModel.qtyitems++;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TouchPill extends StatelessWidget {
  const TouchPill({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.orange,
      radius: 15,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),
        ),
        radius: 17,
      ),
    );
  }
}

const boldTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
const boldTextStyle1 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white);
const boldTextStyle2 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black);
const largeTextStyle =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black);
