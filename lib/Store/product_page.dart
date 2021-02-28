import 'package:animate_do/animate_do.dart';
import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Store/storehome.dart';
import 'package:app_hamburger/Widgets/customAppBar.dart';
import 'package:app_hamburger/Widgets/loadingWidget.dart';
import 'package:app_hamburger/Widgets/myDrawer.dart';
import 'package:app_hamburger/main.dart';
import 'package:app_hamburger/src/burger_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  final ItemColorModel modelcolor;
  ProductPage({this.itemModel, this.modelcolor});
  @override
  _ProductPageState createState() => _ProductPageState();
}

int qtyItems1 = 1;
List<dynamic> _colores = ["Negro", "Verde", "Amarillo", "Azul", ""];
String opcionesColor = "";

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [AgregadosCompras(), Avatar()],
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
                InofrmacionProducto(
                  widget: widget,
                ),
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

class InofrmacionProducto extends StatelessWidget {
  const InofrmacionProducto({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ProductPage widget;

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
            const EdgeInsets.only(top: 20, bottom: 200, left: 25, right: 25),
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
                      onTap: () =>
                          checkItemInCart(widget.itemModel.title, context),
                      child: AddToCartBottom()),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CantidadProducto(),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
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
          border: Border.all(color: Colors.teal,width: 2),
          borderRadius: BorderRadius.circular(48),
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.orange],
            
          ),
        ),
        child: Text(
          "Agregar Compra",
          style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CantidadProducto extends StatefulWidget {
  CantidadProducto({Key key}) : super(key: key);

  @override
  _CantidadProductoState createState() => _CantidadProductoState();
}

class _CantidadProductoState extends State<CantidadProducto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.teal,
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
                  setState(() {
                    qtyItems1--;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Text(
              "$qtyItems1",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
                  setState(() {
                    qtyItems1++;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

const boldTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
const boldTextStyle1 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white);
const boldTextStyle2 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black);
const largeTextStyle =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black);
